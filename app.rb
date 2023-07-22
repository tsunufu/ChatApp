require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'open-uri'
require 'net/http'
require 'json'
require './models'

require 'faye/websocket'

enable :sessions

get '/' do
  erb :home
end

get '/connect' do
    erb :register
end

post '/connect' do
    status_connecting = "connecting"
    user = User.create(name: params[:name], status: status_connecting)
    
    if user.persisted?
        chat = Chat.create
        UserChatRoom.create(user: user, chat: chat)
        session[:user_id] = user.id
        redirect "/chatroom/#{chat.id}"
    else
        @error = "User could not be created."
        erb :register
    end
end

get '/chatroom/:id' do
  chat_id = params[:id]

  @chat = Chat.find(chat_id)
  if @chat.nil?
    redirect to '/', error: "The chatroom does not exist."
  else
    @messages = @chat.messages.order(created_at: :asc)
    
    @user = User.find(session[:user_id])

    erb :chat
  end
end

post '/chatroom/send' do
    user = User.find_by(id: params[:user_id])
    chat = Chat.find_by(id: params[:chat_id])

    if user.nil? || chat.nil?
        @error = "Invalid user or chat."
        erb :chatroom
    else
        message = Message.new(content: params[:content], user: user, chat: chat)

        if message.save
            redirect "/chatroom/#{chat.id}"
        else
            @error = "Message could not be sent."
            erb :chatroom
        end
    end
end