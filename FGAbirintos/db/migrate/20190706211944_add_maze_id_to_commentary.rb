class AddMazeIdToCommentary < ActiveRecord::Migration[5.2]
  def change
    add_reference :commentaries, :maze, foreign_key: true
  end
end
