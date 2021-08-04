class AddUserToGroupUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :group_users, :user, foreign_key: true
  end
end
