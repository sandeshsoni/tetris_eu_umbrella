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

  # # WIP improve code
  # def add_tile_to_board(board, {x,y} = tile, color) do
  #   generate_random_uniq = fn ->
  #     Integer.to_string(:rand.uniform(4294967296), 32)
  #   end
  #   u_indexor = Map.put_new_lazy(board.indexor, y, generate_random_uniq)
  #   lane_key = board.indexor[y]
  #   y_lane = Map.get(board.lanes, lane_key, %{})
  #   y_lane_with_tile_added = Map.put(y_lane, x, color)
  #   u_lanes = Map.put(board.lanes, lane_key, y_lane_with_tile_added)
  #   %Board{
  #     board |
  #     indexor: u_indexor,
  #     lanes: u_lanes
  #   }
  # end


  def add_tile_to_board(board, {x, y} = tile, color) do
    # {remaining_empty_lanes, u_indexor, u_lanes} = if Map.has_key?(board.indexor, y) do
    {u_indexor, u_lanes} = if Map.has_key?(board.indexor, y) do
      lane_key = board.indexor[y]
      y_lane = board.lanes[lane_key]
      y_lane_added = Map.put(y_lane, x, color)
      updated_lanes = Map.put(board.lanes, lane_key, y_lane_added)
      # {board.empty_lane_ids, board.indexor, updated_lanes}
      {board.indexor, updated_lanes}
    else
      # [first | remaining_empty_lanes] = board.empty_lane_ids
      lane_key = generate_random_uniq()
      updated_indexor = Map.put(board.indexor, y, lane_key)
      updated_lanes = Map.put(board.lanes, lane_key, %{x => color})
      # {remaining_empty_lanes, updated_indexor, updated_lanes}
      {updated_indexor, updated_lanes}
    end
    %Board{
      board | indexor: u_indexor,
      lanes: u_lanes,
    }
  end

  defp generate_random_uniq do
    Integer.to_string(:rand.uniform(4294967296), 32)
  end



  # def remove_lanes_from_board(board, lane_indexes) do
  def remove_lanes_from_board(board, lane_indexes) do

    input_lane_indexes_keys = board.indexor
    |> Map.take(lane_indexes)
    |> Map.values

    u_lanes = Map.drop(board.lanes, input_lane_indexes_keys)

    # u_lanes = lane_indexes
    # |> Enum.reduce(board.lanes, fn lane_i, lanes -> Map.drop() end)

    no_of_lanes_in_lane_index_smaller_than = fn(index_key) ->
      Enum.count(lane_indexes, fn(x) -> (x > index_key) end)
    end

    # remove the input_lane indexors
    # increment the indexors by count

    u_indexor = board.indexor
    # |> Map.drop(input_lane_indexes_keys)
    |> Map.drop(lane_indexes)
    |> Enum.reduce(%{}, fn ({index_key, index_val}, acc) ->
      Map.put(acc,
        index_key + no_of_lanes_in_lane_index_smaller_than.(index_key),
        index_val
      )
    end)

    # IO.puts "--------"
    # IO.puts inspect(board.lanes)
    # IO.puts inspect(board.indexor)
    # IO.puts "^^^^^ orig b lanes and indexor"
    # IO.puts inspect(input_lane_indexes_keys)
    # IO.puts inspect(u_indexor)
    # IO.puts inspect(u_lanes)
    # IO.puts "u_i , u_l"

    %Board{
      board | indexor: u_indexor,
      lanes: u_lanes
    }

    # foo = fn(board, lane_index) ->
    #   lane_key = Map.get(board.indexor, lane_index, 0)
    #   y_lane = Map.get(board.lanes, lane_key, %{})
    #   {deleted, remaining_lanes} = Map.pop(board.lanes, lane_key)
    #   {empty_lane_id, occupied_indexors} = Map.pop(board.indexor, lane_index)
    #   %Board{
    #     board |
    #     indexor: occupied_indexors,
    #     # empty_lane_ids: [ lane_key | board.empty_lane_ids],
    #     lanes: remaining_lanes
    #   }
    # end

    # lane_indexes
    # |> Enum.reduce(board, fn lane_index, lanes -> foo.(board, lane_index) end)

  end


end
