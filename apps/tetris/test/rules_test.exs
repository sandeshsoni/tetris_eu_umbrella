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
      shape = Tetris.Core.Shape.new(:s_shape, 11, 20)
      assert Rules.shape_outside_board?(board, shape) == false
    end

    test "bottom boundary over" do
      board = Board.new(50,50)
      shape_outside = Tetris.Core.Shape.new(:s_shape, 11, 51)
      shape_inside = Tetris.Core.Shape.new(:s_shape, 11, 41)
      shape_on_boundary = Tetris.Core.Shape.new(:s_shape, 11, 48)

      assert Rules.touches_footer?(board, shape_outside) == true
      assert Rules.touches_footer?(board, shape_inside) == false
      assert Rules.touches_footer?(board, shape_on_boundary) == true
    end

  end

end
