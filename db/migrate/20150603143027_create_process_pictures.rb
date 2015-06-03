class CreateProcessPictures < ActiveRecord::Migration
  def change
    create_table :process_pictures do |t|
      t.attachment :file
      t.references :work
      t.integer :position

      t.timestamps null: false
    end
  end
end
