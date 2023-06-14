class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :destroy, :edit, :update]
  def index
    @pictures = Picture.all
  end

  def show
    @picture = Picture.find(params[:id])
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to pictures_path, notice:"投稿を削除しました！"
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def create
    @picture = current_user.pictures.build(picture_params)     #ログイン実装で変更？
    if params[:back]
      render :new
    else
      if @picture.save
        ContactMailer.contact_mail(@picture).deliver
        redirect_to pictures_path, notice: "投稿完了しました！"
      else
        render :new
      end
    end
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "投稿を編集しました！"
    else 
      render :edit
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private

    def picture_params
      params.require(:picture).permit(:content, :image, :image_cache)     #image_cache確認
    end

    def set_picture
      @picture = Picture.find(params[:id])
    end
end
