class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.attachment :file
      t.references :work
      t.boolean :visible
      t.integer :position

      t.timestamps null: false
    end
  end
end
