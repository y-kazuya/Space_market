class FavoriteListsController < ApplicationController
  def index
    @favorite_lists = FavoriteList.where(user_id: current_user.id)
  end

  def new
    @favorite_list = FavoriteList.new
  end

  def create
    @favorite_list = FavoriteList.new(fav_list_params)
    if @favorite_list.save
      redirect_to favorite_lists_path
    else
      render :new
    end
  end

  def edit
    @favorite_list = FavoriteList.find(params[:id])
  end

  def update
    @favorite_list = FavoriteList.find(params[:id])
    if @favorite_list.update(fav_list_params)
      redirect_to favorite_lists_path
    else
      render :edit
    end
  end

  def show
    @favorite_list = FavoriteList.find(params[:id])
    @favorites = @favorite_list.favorites
    @favoritesRooms = []
    @favorites.each do |favorite|
      @favoritesRooms << Room.find(favorite.room_id)
    end
  end

  def destroy
    @favorite_list = FavoriteList.find(params[:id])
    @favorite_list.destroy
    redirect_to favorite_lists_path
  end

  private
    def fav_list_params
      params.require(:favorite_list).permit(:name).merge(user_id: current_user.id)
    end

end
