require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  
  setup do
    @list = lists(:one)
  end
  
  
  test "User must be logged in to create a list" do
    get :index
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end  
end

