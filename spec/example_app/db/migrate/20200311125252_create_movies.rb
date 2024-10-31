class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.integer :tmdb_id, null: false, index: {unique: true}
      t.string :title
      t.string :original_title
      t.string :tagline
      t.string :overview
      t.boolean :adult
      t.string :status
      t.integer :revenue
      t.integer :runtime
      t.integer :vote_count
      t.integer :budget
      t.float :vote_average
      t.float :popularity
      t.date :release_date

      t.timestamps
    end
  end
end
