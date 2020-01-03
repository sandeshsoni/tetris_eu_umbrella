defmodule TetrisTest.BoardManagerTest do
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

  describe "add shape to board" do

    test "with coordinates inside board", game_elements do
      board = game_elements.board_20_20
      shape = game_elements.s_shape
      coordinates = {10, 10}

      {:ok, board_with_shape } = BoardManager.add(board, shape, coordinates)
    end

    test "with x coordinates outside board", game_elements do
      board = game_elements.board_20_20
      shape = game_elements.s_shape
      coordinates = {70, 10}

      {:error, _board_with_shape } = BoardManager.add(board, shape, coordinates)
    end

    @tag :skip
    test "with y coordinates outside board", game_elements do
      board = game_elements.board_20_20
      shape = game_elements.s_shape
      coordinates = {10, 70}

      {:error, _board_with_shape } = BoardManager.add(board, shape, coordinates)
    end


  end

  describe "remove lanes" do
    test "one lane matured", game_elements do
      board = game_elements.board_20_20
      shape = game_elements.s_shape
      coordinates = {5, 11}

      {:ok, board_with_shape } = BoardManager.add(board, shape, coordinates)

      board_before_lane_removed = board_with_shape
      board_with_lane_deleted = BoardManager.remove_lanes_from_board(board_before_lane_removed, [11])

      # IO.inspect board_with_shape
      # IO.inspect board_with_lane_deleted

      refute board_with_lane_deleted == board_before_lane_removed
      assert Enum.count(board_with_lane_deleted.indexor) == (Enum.count(board_before_lane_removed.indexor) - 1)
      assert Enum.count(board_with_lane_deleted.lanes) == (Enum.count(board_before_lane_removed.lanes) - 1)

    end

    test "give removed_tile_count for score update?" do
      # get count or just use no_of_lanes * width.
    end

    test "one lane matured, pull down all above lanes" do
    end

  end

end

