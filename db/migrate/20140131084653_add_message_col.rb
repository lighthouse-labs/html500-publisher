class AddMessageCol < ActiveRecord::Migration
  def change
    add_column :users, :message, :string
  end
end
