require 'test_helper'

class QuantitiesControllerTest < ActionController::TestCase
  setup do
    @quantity = quantities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quantities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quantity" do
    assert_difference('Quantity.count') do
      post :create, :quantity => { :amounth => @quantity.amounth, :name => @quantity.name, :storage => @quantity.storage }
    end

    assert_redirected_to quantity_path(assigns(:quantity))
  end

  test "should show quantity" do
    get :show, :id => @quantity
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @quantity
    assert_response :success
  end

  test "should update quantity" do
    put :update, :id => @quantity, :quantity => { :amounth => @quantity.amounth, :name => @quantity.name, :storage => @quantity.storage }
    assert_redirected_to quantity_path(assigns(:quantity))
  end

  test "should destroy quantity" do
    assert_difference('Quantity.count', -1) do
      delete :destroy, :id => @quantity
    end

    assert_redirected_to quantities_path
  end
end
