require 'test_helper'

class ListTest < ActiveSupport::TestCase
  test "a list should have a title" do 
    list = List.new
    assert !list.save
    assert !list.errors[:name].empty?
  end
  
  test "a list should have a description" do 
    list = List.new
    assert !list.save
    assert !list.errors[:description].empty?
  end
end
