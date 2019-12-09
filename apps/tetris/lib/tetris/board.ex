defmodule Tetris.Board do

  defstruct ~w( tiles
    state
    active_shape
    next_shape
 )a


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

  def intersection_check? do
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
  def any_lane_matured? do
    board = %{}

    # lanes_where shaped dropped
    # 19, 20
  end

  def on_matured do
    lanes = %{19 => 17, empty: [19, 1,2]}
    # change key or copy paste to new location

    # if 17 and 19 are matured,
    # shift down 18 by 1, all above 16 by 2
  end

  # lane_seq[4]

end
