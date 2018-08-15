class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|

      t.timestamps
      t.integer :owner_id
      t.references :owner_id
      t.belongs_to :owner
    end
  end
end
