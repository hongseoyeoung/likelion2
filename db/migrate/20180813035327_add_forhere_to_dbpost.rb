class AddForhereToDbpost < ActiveRecord::Migration[5.0]
  def change
    add_column :dbposts, :now_cnt, :integer, default: 1
    add_column :dbposts, :fill_cnt, :integer
    add_column :dbposts, :start_time, :datetime
    add_column :dbposts, :select_style, :string
    add_column :dbposts, :select_eat,  :string
    add_column :dbposts, :hope_gender, :string
    add_column :dbposts, :place, :string
  end
end
