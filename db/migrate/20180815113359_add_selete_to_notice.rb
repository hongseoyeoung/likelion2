class AddSeleteToNotice < ActiveRecord::Migration[5.0]
  def change
    add_column :notices, :choice, :string
  end
end
