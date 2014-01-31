class AddFolderColumn < ActiveRecord::Migration
  def up
    add_column :users, :folder, :string
  end

  def down
    remove_column :users, :folder
  end
end
