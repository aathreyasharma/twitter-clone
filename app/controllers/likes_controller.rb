class LikesController < ApplicationController

  def toggle_likes
    obj_class = Kernel.const_get(params[:obj_type])
    obj = obj_class.find(params[:obj_id])
    if params[:obj_type] == 'Post'
      unless current_user.favorited?(obj)
        current_user.favorite(obj)
      else
        current_user.unfavorite(obj)
      end
    else
      unless params[:like] == 'true'
        fav = Favorite.create(favoritable: obj, favoritor: current_user)
      else
        fav = Favorite.where(favoritable: obj, favoritor: current_user).first
        fav.delete
      end
    end
    render json: {result: 'success', likes_count: obj.reload.favoritors.count }
  end
end
