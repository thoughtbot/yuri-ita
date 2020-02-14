class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.boolean :published, default: false, null: false

      t.timestamps
    end
  end
end
