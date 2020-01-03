defmodule Tetris.Boundary.BoardManager do

  alias Tetris.Core.{Board, Shape}
  alias Tetris.Boundary.{Rules}

  def add(%Board{
        lanes: board_lanes
          } = board,
    %Shape{
      color: shape_color,
      coordinates: coordinates
    } = shape,
    {offset_x, offset_y}
  ) do

    if Rules.shape_outside_board?(board, shape, {offset_x, offset_y}) do
      {:error, :out_of_board}
    else
      tiles = Enum.map(coordinates, fn {x,y} -> {x + offset_x, y + offset_y} end)
      {:ok, add_tiles_to_board(board, tiles, shape_color)}
    end

  end

  def add_tiles_to_board(board, tiles, color) do
    Enum.reduce(tiles, board, fn tile, acc_board -> add_tile_to_board(acc_board, tile, color ) end)
  end

  def add_tile_to_board(board, {x, y} = tile, color) do

    {remaining_empty_lanes, u_indexor, u_lanes} = if Map.has_key?(board.indexor, y) do

      lane_key = board.indexor[y]
      y_lane = board.lanes[lane_key]
      y_lane_added = Map.put(y_lane, x, color)
      updated_lanes = Map.put(board.lanes, lane_key, y_lane_added)

      {board.empty_lane_ids, board.indexor, updated_lanes}
    else
      [first | remaining_empty_lanes] = board.empty_lane_ids

      updated_indexor = Map.put(board.indexor, y, first)
      updated_lanes = Map.put(board.lanes, first, %{x => color})

      {remaining_empty_lanes, updated_indexor, updated_lanes}
    end


    %Board{
      board | indexor: u_indexor,
      lanes: u_lanes,
      empty_lane_ids: remaining_empty_lanes
    }
  end

  def remove_lanes_from_board(board, lane_indexes) do
    foo = fn(board, lane_index) ->

      lane_key = Map.get(board.indexor, lane_index, 0)
      y_lane = Map.get(board.lanes, lane_key, %{})
      {deleted, remaining_lanes} = Map.pop(board.lanes, lane_key)
      {empty_lane_id, occupied_indexors} = Map.pop(board.indexor, lane_index)

      %Board{
        board |
        indexor: occupied_indexors,
        empty_lane_ids: [ lane_key | board.empty_lane_ids],
        lanes: remaining_lanes
      }
    end

    lane_indexes
    |> Enum.reduce(board, fn lane_index, lanes -> foo.(board, lane_index) end)
  end


end
