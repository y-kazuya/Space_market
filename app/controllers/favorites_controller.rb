class FavoritesController < ApplicationController
  def new
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @favorite.save
    redirect_to favorite_lists_path
  end

  def destroy
    @favorite = FavoriteList.find(params[:id])
    @favorite.destroy
    redirect_to favorite_lists_path
  end

  private
  def favorite_params
    params.require(:favorite).permit(:room_id, :favorite_list_id)
  end
end
