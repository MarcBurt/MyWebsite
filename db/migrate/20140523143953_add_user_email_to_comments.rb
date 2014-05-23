class AddUserEmailToComments < ActiveRecord::Migration
  def change

  	add_column :comments, :user_email, :string
  	add_index :comments, :user_email
  end
end
