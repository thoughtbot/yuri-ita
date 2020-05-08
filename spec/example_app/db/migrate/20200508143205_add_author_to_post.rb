class AddAuthorToPost < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :author, null: false, foreign_key: {to_table: :users}
  end
end
