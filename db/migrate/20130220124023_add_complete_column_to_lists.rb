class AddCompleteColumnToLists < ActiveRecord::Migration
  def change
    add_column :lists, :complete, :boolean, :default => false
    add_column :lists, :completed_at, :datetime
  end
end
