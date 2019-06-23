require 'test_helper'

class MesssagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @messsage = messsages(:one)
  end

  test "should get index" do
    get messsages_url, as: :json
    assert_response :success
  end

  test "should create messsage" do
    assert_difference('Message.count') do
      post messsages_url, params: { messsage: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show messsage" do
    get messsage_url(@messsage), as: :json
    assert_response :success
  end

  test "should update messsage" do
    patch messsage_url(@messsage), params: { messsage: {  } }, as: :json
    assert_response 200
  end

  test "should destroy messsage" do
    assert_difference('Message.count', -1) do
      delete messsage_url(@messsage), as: :json
    end

    assert_response 204
  end
end
