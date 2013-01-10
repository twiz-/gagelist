require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "a task should have a descripiton" do 
    task = Task.new
    assert !task.save
    assert !task.errors[:description].empty?
  end
  
  test "a task should have a user associated" do 
    task = Task.new
    assert !task.save
    assert !task.errors[:user_id].empty?
  end
  
  test "a task should have a list associated" do 
    task = Task.new
    assert !task.save
    assert !task.errors[:list_id].empty?
  end
  
end
