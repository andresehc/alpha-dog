require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest 
  
  def setup
    @lacat = Category.create(name: "programming")
    @lacatn = Category.create(name: "diving")
    
  end
  

  test "should show categories listing nooooow" do
    get categories_path 
    assert_template 'categories/index'    
    #con los siguientes assert busca links con el "a[href=?]" y luego se indica que path tiene el link deseado, por ultimo se coloca el nombre o atributo deseado del link
    assert_select "a[href=?]", category_path(@lacat), {text: @lacat.name }
    assert_select "a[href=?]", category_path(@lacatn), {text: @lacatn.name }
  end


end