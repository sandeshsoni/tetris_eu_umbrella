defmodule Tetris.Boundary.BoardManager do
  alias Tetris.Core.{Board, Shape}
  alias Tetris.Boundary.{Rules}

  def add(%Board{lanes: board_lanes} = board,
    %Shape{
      color: shape_color, coordinates: coordinates} = shape,
    {offset_x, offset_y}) do
    if Rules.shape_outside_board?(board, shape, {offset_x, offset_y}) do
      {:error, :out_of_board}
    else
      tiles = Enum.map(coordinates, fn {x,y} -> {x + offset_x, y + offset_y} end)
      u_board = Enum.reduce(tiles, board, fn tile, acc_board -> add_tile_to_board(acc_board, tile, shape_color ) end)
      {:ok, u_board}
    end
  end

  def add_tile_to_board(board, {x,y} = tile, color) do
    generate_random_uniq = fn ->
      Integer.to_string(:rand.uniform(4294967296), 32)
    end
    u_indexor = Map.put_new_lazy(board.indexor, y, generate_random_uniq)
    lane_key = u_indexor[y]
    y_lane = Map.get(board.lanes, lane_key, %{})
    y_lane_with_tile_added = Map.put(y_lane, x, color)
    u_lanes = Map.put(board.lanes, lane_key, y_lane_with_tile_added)
    %Board{ board | indexor: u_indexor, lanes: u_lanes}
  end

  def remove_lanes_from_board(board, lane_indexes) do
    input_lane_indexes_keys = board.indexor
    |> Map.take(lane_indexes)
    |> Map.values

    u_lanes = Map.drop(board.lanes, input_lane_indexes_keys)
    no_of_lanes_in_lane_index_smaller_than = fn(index_key) ->
      Enum.count(lane_indexes, fn(x) -> (x > index_key) end)
    end

    u_indexor = board.indexor
    |> Map.drop(lane_indexes)
    |> Enum.reduce(%{}, fn ({index_key, index_val}, acc) ->
      Map.put(acc,
        index_key + no_of_lanes_in_lane_index_smaller_than.(index_key),
        index_val
      )
    end)

    %Board{ board | indexor: u_indexor, lanes: u_lanes
    }
  end
end
