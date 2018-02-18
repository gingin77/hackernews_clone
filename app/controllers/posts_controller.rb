class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :authenticate_to_submit, only: :new

  helper_method :post, :posts, :comment, :vote, :new_vote

  def new
    @post = Post.new
  end

  def show
  end

  def index
  end

  def create
    @post = Post.new(post_params.merge(submitter: current_user))
    if @post.save
      flash[:alert] = "Your post was saved"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  private

  def posts
    @posts ||= Post.all
  end

  def post
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :url, :text)
  end

  def comment
    Comment.new
  end

  def vote(type, id)
    @vote = Vote.find_by(voteable_type: type, voteable_id: id)
  end

  def new_vote
    @vote = Vote.new
  end
end
