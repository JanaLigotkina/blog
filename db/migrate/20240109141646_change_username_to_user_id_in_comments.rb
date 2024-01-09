class ChangeUsernameToUserIdInComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :temp_user_id, :integer

    execute "UPDATE comments SET temp_user_id = CAST(username AS INTEGER)"

    rename_column :comments, :temp_user_id, :user_id

    remove_column :comments, :username
  end
end
