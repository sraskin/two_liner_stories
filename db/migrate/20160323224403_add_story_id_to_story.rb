class AddStoryIdToStory < ActiveRecord::Migration
  def change
    add_column :stories, :story_id, :string
  end
end
