class ChatroomsController < ApplicationController

  def index
    @chatrooms = Chatroom.where(user_1: current_user).or(Chatroom.where(user_2: current_user))
  end

  def show
    user_1 = current_user
    user_2 = User.find(params[:id])
    existing_chatroom = Chatroom.find_by(user_1: user_1, user_2: user_2) || Chatroom.find_by(user_1: user_2, user_2: user_1)

    if existing_chatroom
      @chatroom = existing_chatroom
    else
      @chatroom = Chatroom.create!(user_1: user_1, user_2: user_2)
    end
    @messages = @chatroom.messages
    @message = Message.new
  end

  def create
  end
  private
  def chatroom_params
    params.require(:chatroom).permit(:user_1_id, :user_2_id)
  end
end
