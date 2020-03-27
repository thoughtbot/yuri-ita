class CreateMovieGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_genres do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end

    add_index :movie_genres, [:movie_id, :genre_id], unique: true
  end
end
