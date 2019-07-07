class MazesController < ApplicationController
  before_action :set_maze, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /mazes
  # GET /mazes.json
  def index
    @mazes = current_user.mazes
  end

  # GET /mazes/1
  # GET /mazes/1.json
  def show
  end

  # GET /mazes/new
  def new
    @maze = Maze.new
    Maze.adjacencyList = []
  end

  # GET /mazes/1/edit
  def edit
  end
  def validateMaze
    if @maze.sizeMaze<3
      @maze.sizeMaze = 3
    elsif @maze.sizeMaze>=101
      @maze.sizeMaze = 100
    end
    if @maze.startingPoint>=@maze.sizeMaze.to_s || @maze.startingPoint<"0"
      @maze.startingPoint = 0
    end
    if @maze.endPoint>=@maze.sizeMaze.to_s || @maze.endPoint<"0"
      @maze.endPoint = @maze.sizeMaze*@maze.sizeMaze-1
    end
  end

  def arraysToString
    #____________________________________________
    @maze.adjacencyList = ""
    i = 0
    until i==@maze.sizeMaze
      @maze.adjacencyList+=@adjacencyList[i].join(",")
      if i!= @maze.sizeMaze-1
          @maze.adjacencyList+=","
      end
      i+=1
    end
    #____________________________________________
  end

  def generateMaze
    validateMaze
    # ------ Gerador do labirinto Com 0, codigo temporario ate implementar o gerador de labs
    i = 0
    @adjacencyList = []
    until i==@maze.sizeMaze
      j = 0
      @adjacencyList.push([])
      until j==@maze.sizeMaze
        @adjacencyList[i].push("0")
        j+=1
      end
      i+=1
    end
    #____________________________________
    arraysToString
  end


  # POST /mazes
  # POST /mazes.json
  def create
    @maze = current_user.mazes.new(maze_params)
    generateMaze
    respond_to do |format|
      if @maze.save
        format.html { redirect_to @maze, notice: 'Labirinto criado com sucesso.' }
        format.json { render :show, status: :created, location: @maze }
      else
        format.html { render :new }
        format.json { render json: @maze.errors, status: :unprocessable_entity }
      end
    end
    #respond_to do |format|
    #format.html { redirect_to new_maze_path}
  end

  # PATCH/PUT /mazes/1
  # PATCH/PUT /mazes/1.json
  def update
    respond_to do |format|
      if @maze.update(maze_params)
        format.html { redirect_to @maze, notice: 'Labirinto atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @maze }
      else
        format.html { render :edit }
        format.json { render json: @maze.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mazes/1
  # DELETE /mazes/1.json
  def destroy
    @maze.destroy
    respond_to do |format|
      format.html { redirect_to mazes_url, notice: 'Labirinto destruído com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maze
      @maze = Maze.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maze_params
      params.require(:maze).permit(:adjacencyList, :solutionMaze, :startingPoint, :endPoint, :sizeMaze)
    end
end
