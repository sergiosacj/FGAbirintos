require 'test_helper'

class MazesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @maze = mazes(:one)
  end

  test "should get index" do
    get mazes_url
    assert_response :success
  end

  test "should get new" do
    get new_maze_url
    assert_response :success
  end

  test "should create maze" do
    assert_difference('Maze.count') do
      post mazes_url, params: { maze: { adjacencyList: @maze.adjacencyList, endPoint: @maze.endPoint, sizeMaze: @maze.sizeMaze, solutionMaze: @maze.solutionMaze, startingPoint: @maze.startingPoint } }
    end

    assert_redirected_to maze_url(Maze.last)
  end

  test "should show maze" do
    get maze_url(@maze)
    assert_response :success
  end

  test "should get edit" do
    get edit_maze_url(@maze)
    assert_response :success
  end

  test "should update maze" do
    patch maze_url(@maze), params: { maze: { adjacencyList: @maze.adjacencyList, endPoint: @maze.endPoint, sizeMaze: @maze.sizeMaze, solutionMaze: @maze.solutionMaze, startingPoint: @maze.startingPoint } }
    assert_redirected_to maze_url(@maze)
  end

  test "should destroy maze" do
    assert_difference('Maze.count', -1) do
      delete maze_url(@maze)
    end

    assert_redirected_to mazes_url
  end
end
