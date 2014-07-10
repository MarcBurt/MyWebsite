class SwitchUserImageToPaperclipAvatar < ActiveRecord::Migration
  def change

    remove_column :users, :image
    add_attachment :users, :avatar
  end
end
