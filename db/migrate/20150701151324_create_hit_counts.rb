class CreateHitCounts < ActiveRecord::Migration
  def change
    create_table :hit_counts do |t|
      t.string :cat
      t.integer :hits

      t.timestamps null: false
    end
  end
end
