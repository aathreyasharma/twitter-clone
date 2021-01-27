class LikesController < ApplicationController
  before_action :set_post, only: %i[ like_post unlike_post ]
  before_action :set_comment, only: %i[ like_comment unlike_comment ]
  # after_action :go_back

  def like_post
    current_user.favorite(@post)
    respond_to do |format|
      format.js { render inline: "location.reload();" }
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  def unlike_post
    current_user.unfavorite(@post)
    respond_to do |format|
      format.js { render inline: "location.reload();" }
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  def like_comment
    current_user.favorite(@comment)
    respond_to do |format|
      format.js { render inline: "location.reload();" }
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  def unlike_comment
    current_user.unfavorite(@comment)
    respond_to do |format|
      format.js { render inline: "location.reload();" }
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def go_back
    redirect_to request.referer
  end

end
