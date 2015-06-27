class RenameAbout < ActiveRecord::Migration
  def change
    rename_table 'abouts', 'about_paragraphs' 
    rename_column 'about_paragraphs', 'paragraph', 'text'
  end
end
