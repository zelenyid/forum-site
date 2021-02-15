class PostsController < ApplicationController
  def new
    page_not_found unless current_user

    @topic = Topic.find(params[:topic_id])
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.create(post_params.merge({ user_id: current_user.id }))

    redirect_to topic_post_path(@topic, @post)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    page_not_found unless current_user

    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params.merge({ user_id: current_user.id }))
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
