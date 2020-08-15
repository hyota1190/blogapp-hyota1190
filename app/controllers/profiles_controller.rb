class ProfilesController < ApplicationController
  before_action :authenticate_user! #ログインしていないとできないと言うことを定義
  
  def show
    @profile = current_user.profile #「profile」は、has_oneで指定した物が当てはめられる
  end
  
  def edit
  #  if current_user.profile.present?
  #    @profile = current_user.profile
  #  else
  #    @profile = current_user.build_profile #has_one独特の表現
  #  end
  # @profile = current_user.profile || current_user.build_profile #上記と同じ条件式を一行で記述
  @profile = current_user.prepare_profile #さらにuser.rbで定義したメソッドで短縮
  end
  
  def update
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)
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