require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest 

  test "get new category form and create category" do
    get new_category_path  
    assert_template 'categories/new'
    assert_difference 'Category.count',1 do
      #Para rails < 5, usar post_via_redirect
      # post_via_redirect categories_path, category: {name:"sports"}
      #post_via_redirect is not available in rails 5, use the following:
      post categories_path, params:{category:{name:"sports"}}
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match "sports",response.body   #busca en el body del response (la ultima pagina que cargo)
  end

  
end