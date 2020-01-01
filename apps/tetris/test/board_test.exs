defmodule Tetris.Core.Board_test do
  use ExUnit.Case
  alias Tetris.Core.{Board, Shape}

  setup do
    {:ok, %{
        board_20_20: Board.new(20, 20),
        board_50_50: Board.new(50, 50),
        board_10_10: Board.new(10, 10),
        s_shape: Shape.new(:s_shape),
        t_shape: Shape.new(:t_shape),
        l_shape: Shape.new(:l_shape),
     }
    }
  end
  describe "new board properties" do

    test "width and height" do
      board = Board.new(100, 50)

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

end
