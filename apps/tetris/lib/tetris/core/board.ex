defmodule Tetris.Core.Board do

  alias Tetris.Core.Shape

  @default_width 40
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


  def check_tile_slot_empty(board,{x, y} = tile) do
    index_y = Map.get(board.indexor, y, 0)
    tile_color = Map.get(board.lanes, index_y, %{}) |> Map.get(x, :empty)

    if tile_color == :empty do
      true
    else
      false
    end
  end

  # lane_seq = {:empty, :empty, :empty, lane_14rand0m, lane_12rand0m}
  # tiles: {1,2} => :red

  # {x, y}
  # lane_11rand0m = %{0: :blue, 1: :nil, 2: green, 3: yello}
  # lane_12rand0m = %{0: :red, 1: :blue, 2: nil, 3: yello}
  # lane_14rand0m = %{0: :red, 1: :red, 2: green, 3: yello}

  # def process do
  #   board = %{1 => %{1 => :a, 2 => :b, 3 => nil}}
  #   access_element = board[1][3]
  #   # store lane here
  #   seq_abc = [{:b, 1}, {:a, 3}]
  #   board_seq_map = %{19 => 1, 20 => 4, empties: [1,2]}
  # end

  # defp intersection_check? do
  #   board = %{}
  #   seq_map = %{19 => 1, 20 => 4, empties: [1,2]}
  #   shape_coords = [{1,1}, {2,3}]
  #   board = Map.put(board, 4, %{1 => :red})
  #   board[ seq_map[20]][1]
  #   Enum.any?(shape_coords, fn coord -> tile_present_in(coord, board) end)
  # end

  # defp tile_present_in(coord, board) do
  #   false
  # end

  def display_lane_tiles(board, lane_no) do
    index_y = Map.get(board.indexor, lane_no, 0)
    Map.get(board.lanes, index_y, %{})
  end

  # get all matured lanes
  # defp any_lane_matured? do
  #   board = %{}
  #   # lanes_where shaped dropped
  #   # 19, 20
  # end

  # defp on_matured do
  #   lanes = %{19 => 17, empty: [19, 1,2]}
  #   # change key or copy paste to new location
  #   # if 17 and 19 are matured,
  #   # shift down 18 by 1, all above 16 by 2
  # end

  # lane_seq[4]

end
