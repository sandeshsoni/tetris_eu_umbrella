defmodule Tetris.Core.Board do

  alias Tetris.Core.Shape

  @default_width 100
  @default_height 50

  defstruct ~w(
    tiles
    seq_map
    width
    height
    indexor
    empty_lane_ids
    lanes
  )a

  # def new(input_width // @default_width, input_height // @default_height  ) do
  def new(input_width \\ @default_width, input_height \\ @default_height  ) do
    %__MODULE__{
      width: input_width,
      height: input_height,
      lanes: %{},
      empty_lane_ids: Enum.map(1..input_height, &(&1)),
      indexor: %{}
      # Map.new(empty_lanes: Enum.map(1..input_height, &(&1)))
    }
  end

  def add_shape(%__MODULE__{
        lanes: board_lanes
                } = board,
    %Shape{ offset_x: shape_offset_x,
            offset_y: shape_offset_y,
            color: shape_color,
            coordinates: coordinates
    } = shape) do

    tiles = Enum.map(coordinates, fn {x,y} -> {x + shape_offset_x, y + shape_offset_y} end)

    # IO.puts inspect(tiles)

    board = add_tiles_to_board(board, tiles, shape_color)

    board
  end

  def add_tiles_to_board(board, tiles, color) do
    Enum.reduce(tiles, board, fn tile, acc_board -> add_tile_to_board(acc_board, tile, color ) end)
  end

  def add_tile_to_board(board, {x, y} = tile, color) do

    # require IEx; IEx.pry
    # IO.puts
    {remaining_empty_lanes, u_indexor, u_lanes} = if Map.has_key?(board.indexor, y) do

      # require IEx; IEx.pry

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


    %__MODULE__{
      board | indexor: u_indexor,
      lanes: u_lanes,
      empty_lane_ids: remaining_empty_lanes
    }
  end

  def check_tile_slot_empty(board,{x, y} = tile) do
    require IEx;
    IEx.pry

    index_y = Map.get(board.indexor, y, 0)
    tile_color = Map.get(board.lanes, index_y, %{}) |> Map.get(x, :empty)

    if tile_color == :empty do
      false
    else
      true
    end

    # index_y = board.indexor(y)
    # board[index_y][x]
  end

  # lane_seq = {:empty, :empty, :empty, lane_14rand0m, lane_12rand0m}
  # tiles: {1,2} => :red

  # {x, y}
  # lane_11rand0m = %{0: :blue, 1: :nil, 2: green, 3: yello}
  # lane_12rand0m = %{0: :red, 1: :blue, 2: nil, 3: yello}
  # lane_14rand0m = %{0: :red, 1: :red, 2: green, 3: yello}

  def process do
    board = %{1 => %{1 => :a, 2 => :b, 3 => nil}}
    access_element = board[1][3]

    # store lane here
    seq_abc = [{:b, 1}, {:a, 3}]
    board_seq_map = %{19 => 1, 20 => 4, empties: [1,2]}

  end

  defp intersection_check? do
    board = %{}
    seq_map = %{19 => 1, 20 => 4, empties: [1,2]}

    shape_coords = [{1,1}, {2,3}]
    board = Map.put(board, 4, %{1 => :red})
    board[ seq_map[20]][1]

    Enum.any?(shape_coords, fn coord -> tile_present_in(coord, board) end)
  end

  defp tile_present_in(coord, board) do
    false
  end

  # get all matured lanes
  defp any_lane_matured? do
    board = %{}

    # lanes_where shaped dropped
    # 19, 20
  end

  defp on_matured do
    lanes = %{19 => 17, empty: [19, 1,2]}
    # change key or copy paste to new location

    # if 17 and 19 are matured,
    # shift down 18 by 1, all above 16 by 2
  end

  # lane_seq[4]

end
