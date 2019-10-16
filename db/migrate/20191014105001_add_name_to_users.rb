class AddNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string ,unique: true, index: true
  end
end
