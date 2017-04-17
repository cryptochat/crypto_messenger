class ChatMessage < ApplicationRecord
  validates :user_id,         presence: true, numericality: true
  validates :interlocutor_id, presence: true, numericality: true
  validates :chat_channel_id, presence: true, numericality: true
  validates :text, presence: true

  belongs_to :chat_channel
  belongs_to :user

  after_create :broadcast_message

  class << self
    def send_message(sender_id, recipient_id, message)
      chat_channel = ChatChannel.find_or_create(sender_id, recipient_id)
      create(user_id: sender_id, interlocutor_id: recipient_id, text: message, chat_channel_id: chat_channel.id)
    end

    def history(current_user_id, interlocutor_id, offset = 0, limit = 20)
      chat_channel = ChatChannel.find_or_create(current_user_id, interlocutor_id)
      where(chat_channel_id: chat_channel.id).offset(offset).limit(limit).order(created_at: :desc)
    end

    def interlocutors(current_user_id)
      sql = <<-SQL.squish
      SELECT *
      FROM chat_channels cc
        JOIN
        (
          SELECT DISTINCT ON (chat_channel_id) *
          FROM chat_messages
          ORDER BY chat_channel_id, created_at DESC
        ) cm ON cm.chat_channel_id = cc.id
      WHERE cc.cache_user_ids @> ARRAY[:user_id]
      ORDER BY cm.created_at DESC;
      SQL

      find_by_sql [sql, user_id: current_user_id]
    end

    def read_all!(user_id)
      where(is_read: false, user_id: user_id).update_all(is_read: true, readed_at: Time.now.utc)
    end
  end

  # TODO: кэширование
  def sender
    User.find_by(id: user_id)
  end

  # TODO: кэширование
  def recipient
    User.find_by(id: interlocutor_id)
  end

  def read?
    is_read
  end

  private

  def render_incoming_message(obj, confirmation)
    ApplicationController.render(template: 'api/v1/chat_messages/incoming_message',
                                 locals: { message: obj, method_name: confirmation })
  end

  # TODO: move to sidekiq
  def broadcast_message
    message_for_sender = render_incoming_message(self, 'confirmation_message')
    WsChatChannel.broadcast_to(sender, Encryption.encrypt(message_for_sender))
    if recipient.online?
      message_for_recipient = render_incoming_message(self, 'incoming_message')
      WsChatChannel.broadcast_to(recipient, Encryption.encrypt(message_for_recipient))
    else
      # push notify
    end
  end
end