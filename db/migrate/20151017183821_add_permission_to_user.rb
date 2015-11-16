class AddPermissionToUser < ActiveRecord::Migration
  def change
  	remove_column :users, :integer_file_name, :string 
  	remove_column :users, :integer_content_type, :string
  	remove_column :users, :integer_file_size, :integer
  	remove_column :users, :integer_updated_at, :datetime
  	remove_column :users, :permission_level, :integer
  	remove_column :users, :permission, :integer


  	add_column :users, :permission, :integer, default: 1
  end
end