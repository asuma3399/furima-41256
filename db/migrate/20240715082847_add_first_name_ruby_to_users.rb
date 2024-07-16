class AddFirstNameRubyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name_ruby, :string, null: false
  end
end
