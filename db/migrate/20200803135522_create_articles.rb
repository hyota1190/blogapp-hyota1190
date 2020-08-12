class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false
      t.string :title, null: false
      t.text :content, null: false  #validationはActive Record側の制限なので、DB側の制限として加えた方が尚良い
      t.timestamps
    end
  end
end
