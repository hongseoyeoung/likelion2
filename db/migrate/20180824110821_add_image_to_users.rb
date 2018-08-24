class AddImageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :image, :string, default: "닐로.jpg"
  end
end
