class Admin::CharactersController < ApplicationController

  def index
    @character = Character.new
    @characters = Character.all
  end

  def edit
    @character = Character.find(params[:id])
  end

  def show
    @character = Character.find(params[:id])
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to admin_characters_path
  end

  private

  def character_params
    params.require(:character).permit(:genre_id, :name, :status, :description, :image)
  end
end