class AddInfoidToDbpost < ActiveRecord::Migration[5.0]
  def change
    add_reference :dbposts, :info, foreign_key: true
  end
end
