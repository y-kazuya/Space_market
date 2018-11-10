class FavoritesController < ApplicationController
  def new
    @favorite = Favorite.new
  end

  def show
    @favorite_lists = FavoriteList.where(user_id: current_user.id)

  end


  def first_create
    @favorite = Favorite.new(favorite_params)
    @favorite.save
    redirect_to space_room_path(params[:space_id], params[:room_id])
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @favorite.save

  end

  def destroy
    @favorite = FavoriteList.find(params[:id])
    @favorite.destroy
    redirect_to favorite_lists_path
  end

  private
  def favorite_params
    params.permit(:room_id).merge(favorite_list_id: current_user.favorite_lists.first.id)
  end
end
