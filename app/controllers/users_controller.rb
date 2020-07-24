class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :corrent_user, only: [:edit, :update]
  def index
      @users = User.all
      # @user = User.find(params[:id])
      @newbook = Book.new
  end
    
  def show
      @user = User.find(params[:id])
      @newbook = Book.new
      @books = @user.books.all
  end
  
  def edit
      @user = User.find(params[:id])
  end
  
  def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to user_path(@user)
        flash[:notice] = "You have updated user successfully."
      else
        render :edit
      end
  end
  
  private
  def corrent_user
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user.id)
    end
  end

  def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
