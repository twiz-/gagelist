class CreateActivityViews < ActiveRecord::Migration
  def change
    create_table :activity_views do |t|
      t.integer :viewer_id
      t.datetime :viewed_on

      t.timestamps
    end
    add_index :activity_views, :viewer_id
  end
end
