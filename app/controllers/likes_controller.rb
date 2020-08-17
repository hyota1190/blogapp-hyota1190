class LikesController < ApplicationController
  before_action :authenticate_user! #ログインしていないとできないと言うことを定義

  def create
    article = Article.find(params[:article_id])
    article.likes.create!(user_id: current_user.id) #保存されなければバグなので、！をつける
    redirect_to article_path(article)
  end
end