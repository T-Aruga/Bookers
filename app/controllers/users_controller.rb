class UsersController < ApplicationController

  before_action :ensure_correct_user, only: [:edit]

  def index
    @users = User.page(params[:page]).reverse_order
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def ensure_correct_user
      @user = User.find(params[:id])
      if current_user.id != @user.id
         redirect_to user_path(current_user.id)
      end
  end

  private

  def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
  end



end
