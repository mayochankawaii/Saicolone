class Admin::GroupCharactersController < ApplicationController

  def index
    @character = Character.new
    @characters = current_user.characters
    @group = Group.find(params[:group_id])
  end

  def show
    @character = Character.find(params[:id])
    @group = Group.find(params[:group_id])
  end

  def destroy
    group = Group.find(params[:group_id])
    character = Character.find(params[:id])
    group_character = GroupCharacter.find_by(group: group, character: character)
    group_character.destroy
    redirect_to admin_group_path(group.id), alert: 'キャラクターをグループから外しました'
  end

  private

  def character_params
    params.require(:character).permit(:genre_id, :name, :status, :description, :image)
  end
end