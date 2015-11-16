class ArticlesController < ApplicationController
	before_action :authenticate_user!, except:[:show,:index]
	before_action :set_article, except:[:index,:new,:create]
	before_action :authenticate_editor!, only: [:new,:create,:update]
	before_action :authenticate_admin!, only: [:destroy,:publish]
	#GET/ARTICLES
	def index
		@articles = Article.paginate(page: params[:page],per_page:5).publicados.ultimos
	end
	#GET/ARTICLES/:ID
	def show
		@article.update_visits
		@comment = Comment.new
	end

	#GET/article/new
	def new
		@article = Article.new
		@categories = Category.all
	end
	def edit
		
	end
	#post/article/create
	def create
		@article = current_user.articles.new(article_params)
		@article.categories = params[:categories]
		
		if @article.save
			redirect_to @article
		else
			render :new
		end
	end
	def update
		
		if @article.update(article_params)
			redirect_to @article
		else
			redirect_to :edit
		end
	end
	def publish
		@article.publish!
		redirect_to @article
	end
	def destroy
		@article.destroy
		redirect_to articles_path

	end

	private
	def set_article
		@article = Article.find(params[:id])
	end
	def article_params
		params.require(:article).permit(:title, :body, :cover, :categorie)
	end

end