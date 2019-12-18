defmodule TetrisTest.GameLogicTest do
  use ExUnit.Case
  alias Tetris.Core.{Game, Shape, Board}
  alias Tetris.Boundary.{Rules, GameLogic}


  describe "new game started" do

    test "new game" do

      board = Board.new(20, 20)
      game = Game.new(%{board: board})

      # new Game is a core function,
      # not a boundary

      # GameLogic.new_game()
      #
      # check bounday left
    end

    @tag :skip
    test "bounday right" do
    end

  end

  describe "rotation" do

    @tag :skip
    test "free rotation"
    @tag :skip
    test "when at corner"
    @tag :skip
    test "when colliding with a tile"
  end

  describe "move" do
    test "free move" do
      board = Board.new(20, 20)
      current_shape = Shape.new(:s_shape)
      game = Game.new(%{board: board, active_shape: current_shape, offset_x: 5, offset_y: 1})
      game_after_move = GameLogic.move(game, :left)

      assert game != game_after_move
    end

    test "left side boundary" do
      board = Board.new(20, 20)
      current_shape = Shape.new(:s_shape)
      game = Game.new(%{board: board, active_shape: current_shape, offset_x: 1, offset_y: 1})
      game_after_move = GameLogic.move(game, :left)

      assert game == game_after_move
    end

    test "right side boundary" do
      board = Board.new(20, 20)
      current_shape = Shape.new(:s_shape)
      game = Game.new(%{board: board, active_shape: current_shape, offset_x: 18, offset_y: 1})
      game_after_move = GameLogic.move(game, :right)

      assert game == game_after_move
    end


    # @tag :skip
    test "when collides with existing tile on x-axis" do
      board = Board.new(20, 20)
      current_shape = Shape.new(:s_shape)
      game = Game.new(%{board: board, active_shape: current_shape, offset_x: 15, offset_y: 10})

      {x_coordinate, y_coordinate} = {14, 10}
      shape_added_board = Board.add_shape(board, current_shape, {x_coordinate, y_coordinate})

      IO.puts inspect(shape_added_board.indexor)
      IO.puts inspect(shape_added_board.lanes)
      IO.puts List.duplicate("-", 10)
      IO.puts inspect(Shape.with_offset_counted(current_shape, game.offset_x, game.offset_y))

      game_after_move = GameLogic.move(%Game{ game | board: shape_added_board}, :left)

      assert game == game_after_move
    end

    # @tag :skip
    # test "when a shape below"

  end

  describe "line matured" do
    @tag :skip
    test "2 lanes matured"
  end

end
