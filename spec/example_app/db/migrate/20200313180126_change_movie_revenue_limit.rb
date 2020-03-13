class ChangeMovieRevenueLimit < ActiveRecord::Migration[6.0]
  def up
    change_column :movies, :revenue, :integer, limit: 8
  end

  def down
    change_column :movies, :revenue, :integer, limit: 4
  end
end
