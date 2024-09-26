class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  # def create
  #   @genre = Genre.new(genre_params)
  #   @genre.save
  #   redirect_to admin_genres_path
  # end
  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      redirect_to admin_genres_path, alert: '空白、または登録済みのジャンルは保存できません'
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      redirect_to edit_admin_genre_path(@genre), alert: '空白、または登録済みのジャンルは保存できません'
    end
  end

  private
    def genre_params
      params.require(:genre).permit(:name)
    end
end