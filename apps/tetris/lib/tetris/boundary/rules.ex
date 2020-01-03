defmodule Tetris.Boundary.Rules do
  alias Tetris.Core.Board

  # def touches_side_boundary?(board, shape) do
  def shape_outside_board?(board, shape, {x_coordinate, y_coordinate}) do
    # IO.puts inspect(x_coordinate)
    # IO.puts inspect(board)
    # IO.puts inspect(y_coordinate)

    Tetris.Core.Shape.with_offset_counted(shape, x_coordinate, y_coordinate)
    |> Enum.reduce_while(false, fn {x, _y}, acc -> if (x > 0 and x < (board.width + 1)), do: {:cont, false}, else: {:halt, true} end)
  end

  ### api
  def validate_shape_position(board, shape, coordinates) do
    if shape_outside_board?(board, shape, coordinates) do
      {:error, :outside}
    else
      {:ok, coordinates}
    end
  end


  #### API
  def detect_colission(board, shape, coordinates) do
    if intersection_x?(board, shape, coordinates) do
      {:error, :tile_present}
    else
      {:ok, coordinates}
    end
  end

  ### API
  def not_touches_ground(board, shape, coordinates) do
    if touches_footer?(board, shape, coordinates) do
      {:error, :touches_ground}
    else
      {:ok, board}
    end
  end

  ### API
  def gravity_pull?(board, shape, {offset_x, offset_y} = coordinates) do
    if intersection_y?(board, shape, coordinates) do
      if offset_y <= shape.length do
        {:error, :game_over}
      else
        {:error, :tile_below}
      end
    else
      {:ok, board}
    end
  end

  def lanes_matured_with_shape_at(board, shape,{_offset_x, offset_y} =  coordinates) do

    # refactor, indexor not needed
    length_lane = fn(lane_no) ->
      idx = Map.get(board.indexor, lane_no, 0)
      len =  Enum.count( Map.get(board.lanes, idx, %{}))

      # IO.puts len
      len
    end

    shape_lanes = shape.coordinates
    # |> Enum.map(fn {x,y} -> {x, y + offset_y} end)
    |> Enum.map(fn {_x, y} -> (y + offset_y) end)
    |> Enum.uniq
    |> Enum.filter(fn lane -> (length_lane.(lane) == board.width) end)


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

  def intersection_y?(board, shape, {x_coordinate, y_coordinate}) do
    Tetris.Core.Shape.with_offset_counted(shape, x_coordinate, y_coordinate)
    |> Enum.reduce_while(false, fn {x, y}, acc -> if Board.check_tile_slot_empty(board, {x, y + 1}), do: {:cont, false}, else: {:halt, true} end)
  end

  def collides_with_board_tiles?(board, shape, {x_coordinate, y_coordinate}) do
    Tetris.Core.Shape.with_offset_counted(shape, x_coordinate, y_coordinate)
    |> Enum.reduce_while(false, fn {x, y}, acc -> if Board.check_tile_slot_empty(board, {x, y}), do: {:cont, false}, else: {:halt, true} end)
  end

  def check_rotate_valid do
  end

  def check_positions_valid do
  end

end
