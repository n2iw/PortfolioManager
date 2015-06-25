class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.text :paragraph
      t.integer :position

      t.timestamps null: false
    end
  end
end
