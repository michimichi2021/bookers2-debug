class AddGroupToGroupUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :group_users, :group, foreign_key: true
  end
end
