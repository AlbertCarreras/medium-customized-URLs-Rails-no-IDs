class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = find_by_slug
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(posts_params(:title, :description))
    if @post.valid?
      @post.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def edit
    @post = find_by_slug
  end

  def update
    @post = find_by_slug
    @post_test = Post.new(posts_params(:title, :description))
    if @post_test.valid?
      @post.slug = nil if @post.title != params[:title]
      @post.update(posts_params(:title, :description))
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post = find_by_slug
    @post.destroy
    redirect_to :posts
  end

  private

  def find_by_slug
    Post.friendly.find_by_slug(params[:slug])
  end

  def posts_params(*args)
    params.require(:post).permit(*args)
  end
end
