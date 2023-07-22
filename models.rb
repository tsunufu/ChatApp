require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
    has_many :messages
    has_many :user_chat_rooms
    has_many :chats, through: :user_chat_rooms
end

class Message < ActiveRecord::Base
    belongs_to :user
    belongs_to :chat
end

class Chat < ActiveRecord::Base
    has_many :user_chat_rooms
    has_many :users, through: :user_chat_rooms
    has_many :messages
end

class UserChatRoom < ActiveRecord::Base
    belongs_to :user
    belongs_to :chat
end