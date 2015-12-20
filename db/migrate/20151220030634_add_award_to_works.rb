class AddAwardToWorks < ActiveRecord::Migration
  def change
    add_column 'works', 'award', 'boolean', default: false
  end
end
