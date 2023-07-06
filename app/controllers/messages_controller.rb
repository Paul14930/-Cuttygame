class MessagesController < ApplicationController
  def create
    @profile = current_user.profile

    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "shared/message", locals: { message: @message, profile: @profile })

      )

      redirect_to chatroom_path(@chatroom.other_user(current_user))
    else
      render "chatrooms/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
