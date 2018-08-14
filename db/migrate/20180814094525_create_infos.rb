class CreateInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :infos do |t|
      t.references :dbpost, foreign_key: true

      t.timestamps
    end
  end
end
