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
    
    def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to article_path(@article), notice: '保存できたよ' #redirectのときのflash書き方
      else
        flash.now[:error] = '保存できませんでした' #renderのときのflash書き方
        render :new
      end      
    end
    
    def edit
      @article = Article.find(params[:id])
    end

    private
    
    def article_params  #privateにする
      params.require(:article).permit(:title, :content)
      # params{article: { title: "aaa", content:"bbb"}}
    end
end
