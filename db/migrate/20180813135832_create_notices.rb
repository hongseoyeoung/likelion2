class CreateNotices < ActiveRecord::Migration[5.0]
  def change
    create_table :notices do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.string :content
      t.boolean :notice, default: false
      t.timestamps
    end
  end
end
