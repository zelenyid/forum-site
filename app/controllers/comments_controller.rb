class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params.merge({ user_id: current_user.id, post_id: params[:post_id] }))

    redirect_to topic_post_path(params[:topic_id], @post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
