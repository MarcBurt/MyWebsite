class AddUidAndProviderToComments < ActiveRecord::Migration
  def change

  	add_column :comments, :user_uid, :string
  	add_column :comments, :user_provider, :string
  end
end
