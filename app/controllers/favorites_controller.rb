class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @articles = current_user.favorite_articles #いいねした記事を全取得
  end
end