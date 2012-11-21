require 'test_helper'

class ChairSchedulesControllerTest < ActionController::TestCase
  setup do
    @chair_schedule = chair_schedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chair_schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chair_schedule" do
    assert_difference('ChairSchedule.count') do
      post :create, chair_schedule: { member_id: @chair_schedule.member_id, schedule_date: @chair_schedule.schedule_date }
    end

    assert_redirected_to chair_schedule_path(assigns(:chair_schedule))
  end

  test "should show chair_schedule" do
    get :show, id: @chair_schedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chair_schedule
    assert_response :success
  end

  test "should update chair_schedule" do
    put :update, id: @chair_schedule, chair_schedule: { member_id: @chair_schedule.member_id, schedule_date: @chair_schedule.schedule_date }
    assert_redirected_to chair_schedule_path(assigns(:chair_schedule))
  end

  test "should destroy chair_schedule" do
    assert_difference('ChairSchedule.count', -1) do
      delete :destroy, id: @chair_schedule
    end

    assert_redirected_to chair_schedules_path
  end
end
