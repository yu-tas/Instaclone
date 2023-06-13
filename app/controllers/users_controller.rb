class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to picture_path(@user.id)
    else
        render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを編集しました！"
    else 
      render :edit
    end
  end

  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favorite_pictures
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :user_image, :password, 
                                                :password_confirmation)
  end
  
end