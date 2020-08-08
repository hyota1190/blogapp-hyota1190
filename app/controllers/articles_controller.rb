class ArticlesController < ApplicationController
    def index   #一覧表示に使うメソッド
      @articles = Article.all
    end

    def show
      @article = Article.find(params[:id])
    end
    
    def new
      @article = Article.new  
    end

end
