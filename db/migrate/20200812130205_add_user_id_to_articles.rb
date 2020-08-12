class AddUserIdToArticles < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :user #関連付けの時に有効なカラム追加法
    #add_column :articles, user_id, :integer    
  end
end
