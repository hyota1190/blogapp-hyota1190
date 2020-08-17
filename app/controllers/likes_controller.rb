class LikesController < ApplicationController
  before_action :authenticate_user! #ログインしていないとできないと言うことを定義

  def create
    article = Article.find(params[:article_id])
    article.likes.create!(user_id: current_user.id) #保存されなければバグなので、！をつける
    redirect_to article_path(article)
  end
  
  def destroy
    article = Article.find(params[:article_id])
    like = article.likes.find_by!(user_id: current_user.id)
    like.destroy!
    redirect_to article_path(article) #なぜarticleを代入？必要なパラメータはarticle_idだから(id: article_id)とかじゃないの？
    #likeのidは使わない（他人のlikeも削除出来てしまうから）
  end
end