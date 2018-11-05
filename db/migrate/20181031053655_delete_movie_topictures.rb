class DeleteMovieTopictures < ActiveRecord::Migration[5.0]
  def change
    remove_column :pictures, :movie, :string
  end
end
