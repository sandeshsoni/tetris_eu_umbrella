defmodule TetrisTest.RulesTest do
  use ExUnit.Case

  alias Tetris.Core.{Game, Shape, Board}
  alias Tetris.Boundary.{Rules}

  describe "boundaries" do
    test "side boundary, negative x" do
      board = Board.new(50,50)

      {x_coordinate, y_coordinate} = {-1, 70}
      shape = Tetris.Core.Shape.new(:s_shape)

      # shape_added_board = Board.add_shape(board, shape_at_custom_position, x_coordinate, y_coordinate)

      assert Rules.shape_outside_board?(board, shape, {x_coordinate, y_coordinate}) == true
    end

    test "side boundary, over board width" do
      board = Board.new(50,50)

      {x_coordinate, y_coordinate} = {11, 20}
      shape = Tetris.Core.Shape.new(:s_shape)

      assert Rules.shape_outside_board?(board, shape, {x_coordinate, y_coordinate}) == false
    end

    test "bottom boundary over" do
      board = Board.new(50,50)

      shape = Tetris.Core.Shape.new(:s_shape)

      coordinates_outside = { 11, 51 }
      coordinates_inside = { 11, 41 }
      coordinates_on_boundary = { 11, 48 }

      assert Rules.touches_footer?(board, shape, coordinates_outside) == true
      assert Rules.touches_footer?(board, shape, coordinates_inside) == false
      assert Rules.touches_footer?(board, shape, coordinates_on_boundary) == true
    end

  end

  describe "touches y axis" do
    test "on empty new board" do
      #
    end

    test "when shape below" do
      board = Board.new(50,50)
      shape = Tetris.Core.Shape.new(:s_shape)
      {x_coordinate, y_coordinate} = {11, 47}
      b_w_s = Board.add_shape(board, shape, {x_coordinate, y_coordinate})

      coordinates_1_above = { 11, 46 }
      coordinates_3_above = { 11, 44 }
      coordinates_far_away = { 15, 44 }

      # just_3_above_shape = Tetris.Core.Shape.new(:s_shape, 11, 44)
      # just_1_above_shape = Tetris.Core.Shape.new(:s_shape, 11, 46)
      # far_away_shape = Tetris.Core.Shape.new(:l_shape, 15, 44)

      assert Rules.touches_y?(b_w_s, shape, coordinates_far_away) == false
      assert Rules.touches_y?(b_w_s, shape, coordinates_3_above) == false
      assert Rules.touches_y?(b_w_s, shape, coordinates_1_above) == true
      # assert Rules.touches_y?(b_w_s, shape) == true
    end
  end

  describe "x intersection with existing shapes" do
    test "insert shape on empty" do
      board = Board.new(50,50)
      shape = Tetris.Core.Shape.new(:s_shape)
      {x_coordinate, y_coordinate} = {11, 45}
      b_w_s = Board.add_shape(board, shape, {x_coordinate, y_coordinate})

      # shape_to_check = Tetris.Core.Shape.new(:l_shape, 15, 44)
      coordinates_far_away = { 15, 44 }
      coordinates_very_close = { 12, 45 }

      # assert Rules.intersection_x?(b_w_s, shape_to_check) == true
      assert Rules.intersection_x?(b_w_s, shape, coordinates_far_away) == false
      assert Rules.intersection_x?(b_w_s, shape, coordinates_very_close) == true

    end
  end

end
