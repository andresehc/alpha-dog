require 'test_helper'
class CategoryTest < ActiveSupport::TestCase
  def setup
    #este metodo siempre va. setup siempre va a correr antes de los test. Sirve para inicializar variables,llamar metodos necesarios, etc
    @category = Category.new(name:"sports")
  end
  test "Category should be valid" do
    #activerecords assertions
    #en este metodo vemos si la variable es valida
    assert @category.valid?
  end 
  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end
  test "name should be unique" do
    @category.save
    category2 = Category.new(name:"sports")
    assert_not category2.valid?
  end
    test "name should not be too long" do
    @category.name = "a" * 20
    assert_not @category.valid?
  end
  test "name should not be too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end
end
