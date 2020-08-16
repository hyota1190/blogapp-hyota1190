# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  birthday     :date
#  gender       :integer
#  introduction :text
#  nickname     :string
#  subscribed   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
  enum gender: { male: 0, female: 1, other: 2 }
  belongs_to :user
  
  def age
    return '不明' unless birthday.present?
    years = Time.zone.now.year - birthday.year #現在（年）を取得 - 誕生日（年）を取得
    days = Time.zone.now.yday - birthday.yday #yday = 1年の始まりからの経過日数を取得
    
    if days < 0 #誕生日が来てから年齢をプラスするための条件式
      "#{years - 1}歳"
    else
      "#{years}歳"
    end
  end
end
