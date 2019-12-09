defmodule Tetris.Boundary.Rules do

  # def touches_side_boundary?(board, shape) do
  def shape_outside_board?(board, shape) do
    Tetris.Core.Shape.with_offset_counted(shape)
    |> Enum.reduce_while(false, fn {x, y}, acc -> if (x > 0 and x < board.width), do: {:cont, false}, else: {:halt, true} end)
  end

  # so that can drop and move
  def touches_footer?(board, shape) do
    Tetris.Core.Shape.with_offset_counted(shape)
    |> Enum.reduce_while(false, fn {x, y}, acc -> if (y < board.height), do: {:cont, false}, else: {:halt, true} end)
  end

  def check_rotate_valid do
  end

  def check_positions_valid do
  end

end
