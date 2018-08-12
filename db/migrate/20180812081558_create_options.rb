class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.integer :now_cnt, default: 1
      t.integer :fill_cnt 
      t.datetime :start_time # 시작 시간
      t.string :selecteat # 가서먹을 것인가? 배달을 시킬것인가 ?
      t.string :forhere # 
      t.string :hope # 희망성별 (동성, 무관)
      t.string :place # 세부 위치 
      t.references :dbpost, foreign_key: true

      t.timestamps
    end
  end
end
