json.extract! maze, :id, :adjacencyList, :solutionMaze, :startingPoint, :endPoint, :sizeMaze, :created_at, :updated_at
json.url maze_url(maze, format: :json)
