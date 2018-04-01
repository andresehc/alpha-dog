class UsersController < ApplicationController
   before_action :set_user,only:[:edit, :update, :show, :destroy]
  def index
    @user = User.all
  end
  def new
    @user = User.new
  end

  def create
    # render plain: params[:article].inspect
    # @user.save
    @user = User.new (user_params)
    if @user.save
      flash[:success] = "User was succesfully created"
      redirect_to articles_path
    else
      render 'new'
    end

    
  end

  def show

    @user = User.find(params[:id])

  end

  def edit

    @user = User.find(params[:id])

  end


  def destroy

    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "The User was eliminated succesfully"
    redirect_to articles_path

  end
  
  def update

    @user = User.find(params[:id])  
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
end



