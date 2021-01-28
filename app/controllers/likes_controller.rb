class LikesController < ApplicationController
  before_action :set_post, only: %i[ like_post unlike_post ]
  before_action :set_comment, only: %i[ like_comment unlike_comment ]

  def like_post
    current_user.favorite(@post)
    go_back
  end

  def unlike_post
    current_user.unfavorite(@post)
    go_back
  end

  def like_comment
    fav = Favorite.create(favoritable: @comment, favoritor: current_user)
    go_back
  end

  def unlike_comment
    fav = Favorite.where(favoritable: @comment, favoritor: current_user).first
    fav.delete
    go_back
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def go_back
    respond_to do |format|
      format.js { render inline: "location.reload();" }
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

end
