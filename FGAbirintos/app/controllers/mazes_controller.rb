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
  end

  # GET /mazes/1/edit
  def edit
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

  def validateMaze
    if @maze.sizeMaze.nil?
      @maze.sizeMaze = 3
    elsif @maze.sizeMaze<3
      @maze.sizeMaze = 3
    elsif @maze.sizeMaze>=101
      @maze.sizeMaze = 78
    end

    if @maze.startingPoint>=@maze.sizeMaze.to_s || @maze.startingPoint<"0"
      @maze.startingPoint = 0
    end
    if @maze.endPoint>=@maze.sizeMaze.to_s || @maze.endPoint<"0"
      @maze.endPoint = @maze.sizeMaze-1
    end
  end

  def arraysToString
    #____________________________________________
    @maze.adjacencyList = ""
    @maze.solutionMaze = ""
    i = 0
    until i==@maze.sizeMaze
      @maze.adjacencyList+=@generatedMaze[i].join(",")
      @maze.solutionMaze+=@answerMaze[i].join(",")
      if i!= @maze.sizeMaze-1
          @maze.adjacencyList+=","
          @maze.solutionMaze+=","
      end
      i+=1
    end
    #____________________________________________
  end

  def indexOutOfBound(x,y,xf,ir_baixo)
    if ir_baixo
      if x<0 || x>=@maze.sizeMaze || y<0 || y>=@maze.sizeMaze || x>xf
        return true
      end
      return false
    else
      if x<0 || x>=@maze.sizeMaze || y<0 || y>=@maze.sizeMaze || x<xf
        return true
      end
      return false
    end
  end

  def generateSolutionMaze # Xpartida = 0 Xchegada = @maze.sizeMaze-1
    xi = @maze.startingPoint.to_i
    yi = 0
    xf = @maze.endPoint.to_i
    yf = @maze.sizeMaze-1
    @answerPath = []
    @answerMaze[xi][yi] = 1
    @generatedMaze[xi][yi] = 1
    @increase = 0
    @answerPath[@increase] = [xi, yi]
    ir_baixo = false
    #Set de Variaveis ____________________________________
    if xi < xf #entao tenho que descer
      ir_baixo = true
    end

    while xi!=xf || yi!=yf
      moeda = rand()
      if ir_baixo && moeda>=0.5
        if !indexOutOfBound(xi+1,yi,xf,ir_baixo)
          xi += 1
        end
      elsif !ir_baixo && moeda>=0.5
        if !indexOutOfBound(xi-1,yi,xf,ir_baixo)
          xi-=1
        end
      else#ir Direita
        if !indexOutOfBound(xi,yi+1,xf,ir_baixo)
          yi+=1
        end
      end
      @answerMaze[xi][yi] = 1
      @generatedMaze[xi][yi] = 1
      @increase+=1
      @answerPath[@increase] = [xi, yi]
    end
  end

  def fillGeneratedMazeWrongPaths()

      path = 0

      while path <= @increase
        x = @answerPath[path][0]
        y = @answerPath[path][1]
        fillNewEspaces(x, y)
        path+=1
      end

  end

  def fillNewEspaces(x, y)
    dFirstColumn =  [0, 1,  0, -1]
    dSecondColumn = [1, 0, -1,  0]
    
    contador = 0
    if x < 0 || y < 0 || x >= @maze.sizeMaze || y >= @maze.sizeMaze
      return nil
    else  
      i = 0
      while i<4 do
        
        xNew = x + dFirstColumn[i]
        yNew = y + dSecondColumn[i]
        if xNew < 0 || yNew < 0 || xNew >= @maze.sizeMaze || yNew >= @maze.sizeMaze 
          i+=1
          next
        end
        
        if @generatedMaze[xNew][yNew] == 1
          contador += 1
        end

        i+=1
      end

      if contador >= 2
        return nil
      else
        @generatedMaze[x][y] = 1          
      end

      i = 0
      while i<4 do

        xNew = x + dFirstColumn[i]
        yNew = y + dSecondColumn[i]

        if xNew < 0 || yNew < 0 || xNew >= @maze.sizeMaze || yNew >= @maze.sizeMaze 
          i+=1
          next
        end

        if @generatedMaze[xNew][yNew] == 0
          fillNewEspaces(xNew, yNew)
        end
        i+=1
      end

      return nil

    end


  end

  def generateMaze
    validateMaze
    # ------ Gerador do labirinto Com 0
    i = 0
    @generatedMaze = []
    @answerMaze = []
    until i==@maze.sizeMaze
      j = 0
      @generatedMaze.push([])
      @answerMaze.push([])
      until j==@maze.sizeMaze
        @generatedMaze[i].push(0)
        @answerMaze[i].push(0)
        j+=1
      end
      i+=1
    end
    generateSolutionMaze
    fillGeneratedMazeWrongPaths
    arraysToString
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
