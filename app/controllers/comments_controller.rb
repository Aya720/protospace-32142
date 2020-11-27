class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      #誰の(＝prototype.id)投稿の詳細ページか
      redirect_to "/prototypes/#{@comment.prototype.id}"
    else
      #ここで作った変数@commentに紐づくprototypeのレコードを変数に代入。ここで持って来た値がないと、コメント投稿後に詳細ページが空になる
      @prototype = @comment.prototype
      #コメント投稿した投稿に紐づくコメントを全て拾ってきている。showのviewでeachとして使われている部分。
      @comments = @prototype.comments
      render 'prototypes/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

end
