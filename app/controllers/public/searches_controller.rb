class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @search = params[:search]
    @range = params[:range]

    if @range == "キャラクター"
      @characters = Character.looks(@search, @word)
      @genres = Genre.all
    end

    # テンプレートのレンダリング
    render "public/searchs/search" # テンプレートのパスを指定してレンダリング
  end
end