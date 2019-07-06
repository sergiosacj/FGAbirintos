class CreateMazes < ActiveRecord::Migration[5.2]
  def change
    create_table :mazes do |t|
      t.text :adjacencyList
      t.text :solutionMaze
      t.string :startingPoint
      t.string :endPoint
      t.integer :sizeMaze

      t.timestamps
    end
  end
end
