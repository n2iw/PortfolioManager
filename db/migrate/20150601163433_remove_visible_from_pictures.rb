class RemoveVisibleFromPictures < ActiveRecord::Migration
  def up
    remove_column :pictures, :visible
  end

  def down
    add_column :pictures, :visible, :boolean
  end
end
