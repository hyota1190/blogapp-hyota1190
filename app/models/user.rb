# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy  #複数形にする、ユーザーが削除されたら、articleも削除される
  has_one :profile, dependent: :destroy #1対1のときのActice Record紐付け
  has_many :likes, dependent: :destroy
  
  delegate :birthday, :age, :gender, to: :profile, allow_nil: true #下のbirthdayメソッド、genderメソッドと同じ物を定義したことになる。
  
  def has_written?(article)
    self.articles.exists?(id: article.id)
  end
  
  def has_liked?(article)
    likes.exists?(id: article.id) #なぜarticle,likeに関わるメソッドをuser.rbに記載するのか確認する、、メソッドがどこにかかるかである
  end
  
  # cohki0305@gmail.com
  def display_name
  #  if profile && profile.nickname
  #    profile.nickname
  #  else 
  #    self.email.split('@').first # => ['cohki0305', 'gmail.com']
  #  end
  
  profile&.nickname || self.email.split('@').first  #&. = ぼっち演算子（オプショナルチェイニング）：profileがnilじゃないとき、右の式を実行する
    
  end
  
  #def birthday
  #  profile&.birthday
  #end
  
  #def gender
  #  profile&.gender
  #end
  
  def prepare_profile
    self.profile || self.build_profile
  end
  
  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end
end
