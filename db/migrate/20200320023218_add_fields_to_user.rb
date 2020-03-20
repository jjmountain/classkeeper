class AddFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :given_name, :string
    add_column :users, :family_name, :string
    add_column :users, :photo, :string
  end
end
