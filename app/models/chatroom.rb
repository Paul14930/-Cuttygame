class Chatroom < ApplicationRecord
  has_many :messages
  belongs_to :user_1, class_name: "User"
  belongs_to :user_2, class_name: "User"



  def other_user(current_user)
    if current_user == user_1
      user_2
    else
      user_1
    end


  end

end
