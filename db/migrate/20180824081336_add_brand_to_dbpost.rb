class AddBrandToDbpost < ActiveRecord::Migration[5.0]
  def change
    add_column :dbposts, :brand, :string
  end
end
