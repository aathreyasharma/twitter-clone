class CommentsController < ApplicationController
  before_action :set_post, only: %i[ add_comment ]

  def add_comment
    comment = @post.comments.build(params[:comment].to_enum.to_h)
    comment.user = current_user
    comment.save!
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Commented!' }
      format.js { render inline: "location.reload();", notice: 'Commented!' }
    end
  end

  def update_comment
    comment = Comment.find(comment_params[:id])
    comment.update(comment_params)
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Comment updated!' }
      format.js# { render notice: 'Comment updated!' }
    end
  end



  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:id, :body, :media, :user_id)
  end

end
