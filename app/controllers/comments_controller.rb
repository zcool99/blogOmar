class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_article
  before_action :authenticate_user!

  respond_to :html

  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.article = @article 
    @comment.save
    redirect_to @comment.article
   #respond_with(@comment)
  end

  def update
    @comment.update(comment_params)
    redirect_to @comment.article
    #respond_with(@comment)
  end

  def destroy
    @comment.destroy
    redirect_to @article
    #respond_with(@comment)
  end

  private

  	def set_article
  		@article = Article.find(params[:article_id])
  	end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:user_id, :article_id, :body)
    end
end
