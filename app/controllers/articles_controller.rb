class ArticlesController < ApplicationController
    def index   #一覧表示に使うメソッド
        @articles = Article.all
    end

end
