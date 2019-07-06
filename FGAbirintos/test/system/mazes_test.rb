require "application_system_test_case"

class MazesTest < ApplicationSystemTestCase
  setup do
    @maze = mazes(:one)
  end

  test "visiting the index" do
    visit mazes_url
    assert_selector "h1", text: "Mazes"
  end

  test "creating a Maze" do
    visit mazes_url
    click_on "New Maze"

    fill_in "Adjacencylist", with: @maze.adjacencyList
    fill_in "Endpoint", with: @maze.endPoint
    fill_in "Sizemaze", with: @maze.sizeMaze
    fill_in "Solutionmaze", with: @maze.solutionMaze
    fill_in "Startingpoint", with: @maze.startingPoint
    click_on "Create Maze"

    assert_text "Maze was successfully created"
    click_on "Back"
  end

  test "updating a Maze" do
    visit mazes_url
    click_on "Edit", match: :first

    fill_in "Adjacencylist", with: @maze.adjacencyList
    fill_in "Endpoint", with: @maze.endPoint
    fill_in "Sizemaze", with: @maze.sizeMaze
    fill_in "Solutionmaze", with: @maze.solutionMaze
    fill_in "Startingpoint", with: @maze.startingPoint
    click_on "Update Maze"

    assert_text "Maze was successfully updated"
    click_on "Back"
  end

  test "destroying a Maze" do
    visit mazes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Maze was successfully destroyed"
  end
end
