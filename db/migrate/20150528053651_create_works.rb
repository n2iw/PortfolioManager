class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name
      t.attachment :thumbnail
      t.integer :position, default: 0
      t.boolean :visible, default: false
      t.text :description

      t.timestamps null: false
    end
  end
end
