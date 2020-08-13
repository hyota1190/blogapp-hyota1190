class ProfilesController < ApplicationController
  before_action :authenticate_user! #ログインしていないとできないと言うことを定義
  
  def show
    @profile = current_user.profile #「profile」は、has_oneで指定した物が当てはめられる
  end
  
  def edit
    @profile = current_user.build_profile #has_one独特の表現
  end
  
  def update
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to profile_path, notice: 'プロフィールを更新'
    else
      flash.now[:error] = '更新出来ませんでした'
      render :edit
    end
  end
  
  private
  def profile_params
    params.require(:profile).permit(
      :nickname,
      :introduction,
      :gender,
      :birthday,
      :subscribed
    )
  end
end