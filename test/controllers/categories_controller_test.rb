require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest 

  def setup
    @category = Category.create(name:"Postres")
    @user = User.create(username:"pepe",email:"bb@gm.com",password:"password",admin: true)
    puts "El user es:   #{@user}"
  end

  test "Should get categories index" do
    sign_in_as(@user, "password") 
    get categories_path
    assert_response :success
  end

  test "Should get new category" do
    sign_in_as(@user, "password") 
    get new_category_path
    assert_response :success
  end
  
  test "Should get show" do
    get category_path(@category)
    assert_response :success
  end
  
  test "should redirect when admin not logged in" do

    assert_no_difference 'Category.count' do
      post categories_path, params:{category:{name:"sports"}} #en rails < 5 usar la siguiente==> post :create,category: {name: "sports"}
    end

  end

  test "should get new" do
    sign_in_as(@user, "password") 
    get new_category_path
    assert_response :success 
  end



end
