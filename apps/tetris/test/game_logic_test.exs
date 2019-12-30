defmodule TetrisTest.GameLogicTest do
  use ExUnit.Case
  alias Tetris.Core.{Game, Shape, Board}
  alias Tetris.Boundary.{Rules, GameLogic, BoardManager}

  setup do

    {:ok, %{
        board_20_20: Board.new(20, 20),
        board_10_10: Board.new(10, 10),
        s_shape: Shape.new(:s_shape),
        t_shape: Shape.new(:t_shape),
     }
    }
  end

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

    test "free rotation", elements do
      game = Game.new(%{
            board: elements.board_20_20,
            current_shape: elements.s_shape
                      })

      game_after_step = GameLogic.rotate(game)

      assert game != game_after_step
    end

    @tag :skip
    test "when at corner"
    @tag :skip
    test "when colliding with a tile"
  end

  describe "move" do
    test "free move",elements do
      game = Game.new(%{
            board: elements.board_20_20,
            active_shape: elements.s_shape,
            offset_x: 5, offset_y: 1
                      })
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

    test "when collides with existing tile on x-axis", game_elements do

      {x_coordinate, y_coordinate} = {14, 10}
      {:ok, shape_added_board} = BoardManager.add(game_elements.board_20_20, game_elements.s_shape, {x_coordinate, y_coordinate})

      game = Game.new(%{board: shape_added_board,
                        active_shape: game_elements.s_shape,
                        offset_x: 15, offset_y: 10})
      game_after_move = GameLogic.move(game, :left)

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
