require 'test_helper'

class AgencyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success

    assert_select '#columns #side a', :minimum => 4
    assert_select '#main .entry', 4
  end

end
