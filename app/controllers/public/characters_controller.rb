class Public::CharactersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    if current_user
      @character = Character.new
      @characters = current_user.characters
    else
      redirect_to new_user_session_path, alert: 'ログインが必要です。'
    end
  end

  def new
    if current_user
      @character = Character.new
    else
      redirect_to new_user_session_path, alert: 'ログインが必要です。'
    end
  end

  def create
    @character = Character.new(character_params)
    @character.user_id = current_user.id
    if @character.save
      redirect_to character_path(@character), notice: 'キャラクターを投稿しました'
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
      redirect_to character_path(@character), notice: 'キャラクターを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to characters_path, alert: 'キャラクターを削除しました'
  end

  private

  def character_params
    params.require(:character).permit(:genre_id, :name, :status, :description, :image)
  end

  def ensure_correct_user
    @character = Character.find(params[:id])
    unless @character.user == current_user
      redirect_to characters_path
    end
  end
end