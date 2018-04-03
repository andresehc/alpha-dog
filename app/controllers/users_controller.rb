class UsersController < ApplicationController
  before_action :set_user,only:[:edit, :update, :show]
  # before_action :require_user,except:[:index,:show]  Aqui no se usa
  before_action :require_same_user, only:[:edit, :destroy]
  before_action :require_admin, only:[:destroy]
  def index
    @users = User.paginate(page: params[:page], per_page: 4)
  end
  

  def new
    @user = User.new
  end

  def create
    # render plain: params[:article].inspect
    # @user.save
    @user = User.new (user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "User was succesfully created"
      redirect_to user_path(@user)
    else
      render 'new'
    end

    
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 2)
  end

  def edit
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "The User and all the articles created by user were eliminated succesfully"
    redirect_to articles_path
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Your information was successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end 

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.required(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only edit your own user"
      redirect_to root_path
    end
  end

  def require_admin
    if current_user != @user && !current_user.admin?
      flash[:danger] = "Warning! Only Admin users can perform that action"
      redirect_to root_path
    end
  end
end




