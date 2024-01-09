class CommentsController < ApplicationController
  def create
    @post    = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      redirect_to @post, alert: 'Only registered users can add comments!'
    end
  end

  def edit
    @post    = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update
    @post    = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @post, notice: 'Comment was successfully updated.'
    else
      redirect_to @post, alert: 'Comment was not updated.'
    end
  end

  def destroy
    @post    = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      redirect_to @post, notice: 'Comment was successfully deleted.'
    else
      redirect_to @post, alert: 'Comment was not deleted.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :body)
  end
end
