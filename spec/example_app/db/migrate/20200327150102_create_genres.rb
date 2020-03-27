class CreateGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :genres do |t|
      t.integer :tmdb_id, null: false, index: { unique: true }
      t.string :name

      t.timestamps
    end
  end
end
