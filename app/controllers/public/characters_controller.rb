class Public::CharactersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @character = Character.new
    @characters = Character.all
  end

  def new
    if current_user
      @character = Character.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @character = Character.new(character_params)
    @character.user_id = current_user.id
    if @character.save
      redirect_to character_path(@character), notice: '新規投稿が完了しました。'
    else
      render :new
    end
  end

  def edit
    @character = Character.find(params[:id])
  end

  def show
    @character = Character.find(params[:id])
  end

  def update
    @character = Character.find(params[:id])
    if @character.update(character_params)
      redirect_to character_path(@character), notice: 'ステータスを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to characters_path
  end

  private

  def character_params
    params.require(:character).permit(:genre_id, :name, :status, :introduction, :image)
  end

  def ensure_correct_user
    @character = Character.find(params[:id])
    unless @character.user == current_user
      redirect_to characters_path
    end
  end
end