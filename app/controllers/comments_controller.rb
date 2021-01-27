class CommentsController < ApplicationController
  before_action :set_post, only: %i[ add_comment ]

  def add_comment
    comment = @post.comments.build(params[:comment].to_enum.to_h)
    comment.user = current_user
    if comment.save
      redirect_to request.referer, notice: 'Commented!'
    else
      redirect_to request.referer, notice: 'Unable to comment :('
    end
  end


  private

  def set_post
    @post = Post.find(params[:post_id])
  end

end
