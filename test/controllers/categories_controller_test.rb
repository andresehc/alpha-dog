require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest 

  def setup
    @category = Category.create(name:"Postres")
  end

  test "Should get categories index" do
    get categories_path
    assert_response :success
  end

  test "Should get new category" do
    get new_category_path
    assert_response :success
  end
  
  test "Should get show" do
    get category_path(@category)
    assert_response :success
  end
  


end
