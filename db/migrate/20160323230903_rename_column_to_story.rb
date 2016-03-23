class RenameColumnToStory < ActiveRecord::Migration
  def change
  	rename_column :stories, :story_id, :post_id
  end
end
