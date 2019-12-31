defmodule Tetris.Boundary.GameLogic do
  alias Tetris.Core.{Board, Shape, Game}
  alias Tetris.Boundary.{Rules, BoardManager}

  def rotate(%Game{ offset_x: offset_x,
                    offset_y: offset_y,
                    active_shape: %Shape{coordinates: coordinates} = active_shape,
                    board: board
                  } = game) do

    # IO.puts "rotate called"

    rotated_shape = Shape.rotate(active_shape)
    %Game{game | active_shape: rotated_shape}
  end

  #
  def move(%Game{ offset_x: offset_x,
                  offset_y: offset_y,
                  active_shape: shape,
                  board: board
                } = game, :left) do
    with u_coordinates <- { offset_x - 1, offset_y},
         {:ok, coordinates} <- Rules.validate_shape_position(board, shape, u_coordinates),
         {:ok, coordinates} <- Rules.detect_colission(board, shape, u_coordinates),
         {:ok, updated_game} <- Rules.touches_ground(board, shape, u_coordinates)
         # {:ok, no_lane_matured} <- Rules.no_lane_matures(board, shape, u_coordinates)
      do
      %Game{game | offset_x: offset_x - 1}
      else
        {:error, :outside} -> game
      {:error, :tile_present} -> game
        {:error, :touches_ground} -> move_for_touched_ground(game)
      {:error, :lane_matured} -> step_for_lane_matured(game)
    end
  end

  def move_for_touched_ground(game) do
    random_shape = Shape.new(:l_shape)
    board = BoardManager.add(game.board, game.active_shape, {game.offset_x, game.offset_y})
    %Game{ game |
           offset_x: 0,
           offset_y: 5,
           active_shape: game.next_shape,
           next_shape: random_shape,
           board: board
    }
  end

  def step_for_lane_matured(game) do
    game
  end

  def move(%Game{ offset_x: offset_x,
                  offset_y: offset_y,
                  active_shape: shape,
                  board: board
                } = game, :left) do
    with {:ok, coordinates} <- Rules.validate_shape_position(board, shape, {offset_x, offset_y}),
         {:error, _coordinates} <- Rules.detect_colission(board, shape, coordinates)
    # {:ok, false} <- Rules.touches_y_axis?(board, shape, coordinates)
    # with {:ok, true} = Rule.touches_bottom_lane_axis?()
    # # with {:ok, false} = Rule.any_lane_matures?(board, tiles)
      do

      IO.puts "detect collission false"

      {u_offset_x, u_offset_y} = coordinates
      %Game{game | offset_x: u_offset_x}
    end
  end

  def move(%Game{ offset_x: offset_x,
                  offset_y: offset_y,
                  active_shape: shape,
                  board: board
                } = game, :right) do
    with u_coordinates <- { offset_x + 1, offset_y},
         {:ok, coordinates} <- Rules.validate_shape_position(board, shape, u_coordinates),
         {:ok, coordinates} <- Rules.detect_colission(board, shape, u_coordinates),
         {:ok, updated_game} <- Rules.touches_ground(board, shape, u_coordinates)
         # {:ok, no_lane_matured} <- Rules.no_lane_matures(board, shape, u_coordinates)
      do
      %Game{game | offset_x: offset_x - 1}
      else
        {:error, :outside} -> game
      {:error, :tile_present} -> game
        {:error, :touches_ground} -> move_for_touched_ground(game)
      {:error, :lane_matured} -> step_for_lane_matured(game)
    end
  end


  def move(%Game{ offset_x: offset_x,
                  offset_y: offset_y,
                  active_shape: shape,
                  board: board
                } = game, :down) do
    with u_coordinates <- { offset_x, offset_y + 1},
         {:ok, coordinates} <- Rules.validate_shape_position(board, shape, u_coordinates),
         {:ok, coordinates} <- Rules.detect_colission(board, shape, u_coordinates),
         {:ok, updated_game} <- Rules.touches_ground(board, shape, u_coordinates)
         # {:ok, no_lane_matured} <- Rules.no_lane_matures(board, shape, u_coordinates)
      do
      %Game{game | offset_x: offset_x - 1}
      else
        {:error, :outside} -> game
      {:error, :tile_present} -> game
        {:error, :touches_ground} -> move_for_touched_ground(game)
      {:error, :lane_matured} -> step_for_lane_matured(game)
    end
  end

  def move(game, move_direction) do
    # score
    # active_shape
    # next_shape
    # board
    game
  end

end
