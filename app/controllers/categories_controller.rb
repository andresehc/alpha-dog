
class CategoriesController < ApplicationController
  before_action :require_admin, except:[:index,:show]
  before_action :set_category,only:[:edit, :update, :show]
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
    def new
      @category = Category.new
    end


  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "The category was succesfully created"
      redirect_to categories_path
    else
      render 'new'
    end    
  end

  private
    def category_params
      params.required(:category).permit(:name)
    end
    def set_category
      @category = Category.find(params[:id])
    end
    def require_admin 
      if !logged_in? || (logged_in? && !current_user.admin?)
        flash[:danger] = "Only admins can perform that action"
        redirect_to categories_path
      # else
      #   render 'new'
      end 
    end
end