require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest 
  def setup
    @user = User.create(username:"pepe",email:"bb@gm.com",password:"password",admin: true)
  end
  test "get new category form and create category" do
    sign_in_as(@user, "password") 
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

  test "Invalid category submission results in failure" do
    sign_in_as(@user, "password") 
    get new_category_path  
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do 
      #El assert pasa si no hay diferencia en el Category.count luego de crear un usuario sin nombre
      post categories_path, params:{category:{name:" "}}
      # follow_redirect!
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title' 
    #el assert pasa si existe el elemento h2.panel-title en la ultima pagina cargada categories/new
    assert_select 'div.panel-body'
  end
  
end