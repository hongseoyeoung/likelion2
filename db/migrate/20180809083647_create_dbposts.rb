class CreateDbposts < ActiveRecord::Migration[5.0]
  def change
    create_table :dbposts do |t|
      t.string :menu
      t.string :school
      t.string :title
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
