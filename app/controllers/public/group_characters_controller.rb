class Public::GroupCharactersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @character = Character.new
    @characters = current_user.characters
    @group = Group.find(params[:group_id])
  end

  def create
    group = Group.find(params[:group_id])
    character = Character.find(params[:character_id])
    # user = current_user
    group_character = GroupCharacter.new
    group_character.character_id = character.id
    group_character.group_id = group.id
    group_character.save
    redirect_to group_path(group.id)
  end

  def show
    @character = Character.find(params[:id])
    @group = Group.find(params[:id])
  end

  def destroy
    group = Group.find(params[:group_id])
    user = current_user
    group.users.delete(user)
    redirect_to groups_path
  end

  private

  def character_params
    params.require(:character).permit(:genre_id, :name, :status, :description, :image)
  end

  def ensure_correct_user
    @character = Character.find(params[:id])
    unless @character.user == current_user
      redirect_to group_characters_path
    end
  end
end