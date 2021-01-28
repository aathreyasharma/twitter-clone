class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy publish ]

  def index
    @posts = Post.published.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def my_posts
    @posts = current_user.posts.order(created_at: :desc, status: :asc).page(params[:page]).per(10)
  end

  def publish
    if @post.published!
      redirect_to my_posts_posts_path, notice: "Post Published!"
    else
      redirect_to my_posts_posts_path, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id] || params[:post_id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body, :media, :user_id)
    end
end
