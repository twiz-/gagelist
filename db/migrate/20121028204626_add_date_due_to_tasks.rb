class AddDateDueToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :due_date, :date
    add_index  :tasks, :due_date
  end
end
