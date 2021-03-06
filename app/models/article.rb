# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2, maximum: 100 },
                    format: { with: /\A(?!\@)/ }
  validates :content, presence: true, length: { minimum: 10}, uniqueness: true

  validate :validate_title_and_content_length
  #validate 独自ルール
  
  has_many :comments, dependent: :destroy #複数形にする、記事が削除されたら、commentも削除される
  has_many :likes, dependent: :destroy
  has_one_attached  :eyecatch
  belongs_to :user  #userに紐づける

  def display_created_at
    I18n.l(self.created_at, format: :default)
  end
  
  def author_name
    user.display_name
  end
  
  def like_count
    likes.count
  end

  private
  def validate_title_and_content_length
    char_count = self.title.length + self.content.length
    unless char_count > 100
      errors.add(:content,'100文字以上で！')
      #自分でエラーを追加するときの構文
    end
  end
end
