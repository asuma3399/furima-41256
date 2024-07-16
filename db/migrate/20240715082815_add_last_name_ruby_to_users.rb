class AddLastNameRubyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_name_ruby, :string, null: false
  end
end
