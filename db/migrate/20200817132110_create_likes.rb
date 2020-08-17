class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user, nul: false
      t.references :article, null: false
      t.timestamps
    end
  end
end
