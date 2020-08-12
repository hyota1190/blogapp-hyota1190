class ArticlesController < ApplicationController
    before_action :set_article, only: [:show]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index   #一覧表示に使うメソッド
      @articles = Article.all
    end

    def show
    end

    def new
      @article = current_user.articles.build  #Article.newとほぼ同義。ユーザと紐づけた為、表記が変わる
    end

    def create
      @article = current_user.articles.build(article_params)  #Article.newとほぼ同義
      if @article.save
        redirect_to article_path(@article), notice: '保存しました' #redirectのときのflash書き方
      else
        flash.now[:error] = '保存できませんでした' #renderのときのflash書き方
        render :new
      end
    end

    def edit
      @article = current_user.articles.find(params[:id])  #自分の記事しか編集できないようにする処理
    end

    def update
      @article = current_user.articles.find(params[:id])  #自分の記事しか更新できないようにする処理
      if @article.update(article_params)
        redirect_to article_path(@article), notice: '更新できました'
      else
        flash.now[:error] = '更新できませんでした'
        render :edit
      end
    end

    def destroy
      article = current_user.articles.find(params[:id]) #自分の記事しか削除できないようにする処理
      article.destroy!  #「!」例外発生時に処理を止める
      redirect_to root_path, notice: '削除に成功しました'
    end

    private

    def article_params  #privateにする
      params.require(:article).permit(:title, :content)
      # params{article: { title: "aaa", content:"bbb"}}
    end

    def set_article
      @article = Article.find(params[:id])
    end
end
