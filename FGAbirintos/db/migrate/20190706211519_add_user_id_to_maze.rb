class AddUserIdToMaze < ActiveRecord::Migration[5.2]
  def change
    add_reference :mazes, :user, foreign_key: true
  end
end
