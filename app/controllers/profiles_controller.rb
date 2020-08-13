class ProfilesController < ApplicationController
  before_action :authenticate_user! #ログインしていないとできないと言うことを定義
  
  def show
    @profile = current_user.profile #「profile」は、has_oneで指定した物が当てはめられる
  end
  
  def edit
  end
end