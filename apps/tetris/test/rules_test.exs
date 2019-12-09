defmodule TetrisTest.RulesTest do
  use ExUnit.Case

  alias Tetris.Core.{Game, Shape, Board}
  alias Tetris.Boundary.{Rules}

  describe "boundaries side and bottom" do
    test "side boundary, negative x" do
      board = Board.new(50,50)
      shape = Tetris.Core.Shape.new(:s_shape, -1, 70)
      assert Rules.shape_outside_board?(board, shape) == true
    end

    test "side boundary, over board width" do
      board = Board.new(50,50)
      shape = Tetris.Core.Shape.new(:s_shape, 11, 70)
      assert Rules.shape_outside_board?(board, shape) == false
    end
  end

end
