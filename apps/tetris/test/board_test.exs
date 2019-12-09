defmodule Tetris.Core.Board_test do
  use ExUnit.Case
  alias Tetris.Core.{Board, Shape}

  describe "new board properties" do

    test "width and height" do
      board = Board.new()

      assert board.width == 100
      assert board.height == 50
    end

    test "indexor and lanes" do
      board = Board.new()
      assert board.lanes == %{}
    end

    test "no occpied lanes initially" do
      board = Board.new()
      assert board.indexor == %{}
    end

  end

  describe "add shape to board" do

    test "ignoring rules" do
      board = Board.new()
      shape_at_custom_position = Shape.new(:s_shape, 20, 40)

      shape_added_board = Board.add_shape(board, shape_at_custom_position)

      refute board.empty_lane_ids == shape_added_board.empty_lane_ids
    end

    test "no duplicate filled lanes" do
      board = Board.new()
      shape_at_custom_position = Shape.new(:s_shape, 20, 40)

      shape_added_board = Board.add_shape(board, shape_at_custom_position)

      indexor_count = shape_added_board.indexor
      |> Map.values
      |> length

      uniq_indexor_count = shape_added_board.indexor
      |> Map.values
      |> Enum.uniq
      |> length

      assert indexor_count == uniq_indexor_count
    end

  end

end
