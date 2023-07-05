class AddUserIdToChatroom < ActiveRecord::Migration[7.0]
  def change
    add_reference :chatrooms, :user_1, null: false, foreign_key: {to_table: :users}
    add_reference :chatrooms, :user_2, null: false, foreign_key: {to_table: :users}
  end
end
