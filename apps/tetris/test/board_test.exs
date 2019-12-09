defmodule Tetris.Core.Board_test do
  use ExUnit.Case
  alias Tetris.Core.Board

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
      assert Map.delete(board.indexor, :empty_lanes) == %{}
    end

  end

end
