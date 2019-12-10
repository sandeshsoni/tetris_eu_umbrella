defmodule Tetris.Boundary.Rules do
  alias Tetris.Core.Board

  # def touches_side_boundary?(board, shape) do
  def shape_outside_board?(board, shape, {x_coordinate, y_coordinate}) do
    Tetris.Core.Shape.with_offset_counted(shape, x_coordinate, y_coordinate)
    |> Enum.reduce_while(false, fn {x, y}, acc -> if (x > 1 and x < board.width), do: {:cont, false}, else: {:halt, true} end)
  end

  # so that can drop and move
  def touches_footer?(board, shape, {x_coordinate, y_coordinate}) do
    Tetris.Core.Shape.with_offset_counted(shape, x_coordinate, y_coordinate)
    |> Enum.reduce_while(false, fn {_x, y}, acc -> if (y < board.height), do: {:cont, false}, else: {:halt, true} end)
  end

  def touches_y?(board, shape, {x_coordinate, y_coordinate}) do

    Tetris.Core.Shape.with_offset_counted(shape, x_coordinate, y_coordinate)
    |> Enum.reduce_while(false, fn {x, y}, acc -> if Board.check_tile_slot_empty(board, {x, y + 1}), do: {:cont, false}, else: {:halt, true} end)
  end

  def intersection_x?(board, shape, {x_coordinate, y_coordinate}) do
    Tetris.Core.Shape.with_offset_counted(shape, x_coordinate, y_coordinate)
    |> Enum.reduce_while(false, fn {x, y}, acc -> if Board.check_tile_slot_empty(board, {x, y}), do: {:cont, false}, else: {:halt, true} end)
  end

  def check_rotate_valid do
  end

  def check_positions_valid do
  end

end
