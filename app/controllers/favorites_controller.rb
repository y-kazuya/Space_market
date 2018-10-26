class FavoritesController < ApplicationController
end



#   def create
#     user = current_user
#     room = Room.find(params[:room_id])
#     if Favorite.create( favorite_list_id: favorite_list_.id, room_id: room.id)
#       redirect_to room
#     else
#       redirect_to root_url
#     end
#   end

#   def destroy
#     user=current_user
#     room = Room.find(params[:post_id])
#     if favorite = Favorite.find_by( favorite_list_id: favorite_list_.id, room_id: room.id)
#       favorite.delete
#       redirect_to users_path(current_user)
#     else
#       redirect_to root_url
#     end
#   end
# end
