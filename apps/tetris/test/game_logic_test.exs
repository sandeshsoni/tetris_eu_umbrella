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
      current_shape = Shape.new(:s_shape, 1,1)
      game = Game.new(%{board: board})
      game_after_move = GameLogic.move(game, :left)

      assert game != game_after_move
    end

    test "left side boundary" do
      board = Board.new(20, 20)
      current_shape = Shape.new(:s_shape, 1,1)
      game = Game.new(%{board: board})
      game_after_move = GameLogic.move(game, :left)

      assert game == game_after_move
    end

    # # @tag :skip
    # test "when collides with existing tile on x-axis"
    # @tag :skip
    # test "when a shape below"

  end

  describe "line matured" do
    @tag :skip
    test "2 lanes matured"
  end

end
