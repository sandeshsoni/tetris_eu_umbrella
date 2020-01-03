defmodule Tetris.Boundary.GameLogic do
  alias Tetris.Core.{Board, Shape, Game}
  alias Tetris.Boundary.{Rules, BoardManager}

  def rotate(%Game{ offset_x: offset_x,
                    offset_y: offset_y,
                    active_shape: %Shape{coordinates: coordinates} = active_shape,
                    board: board
                  } = game) do
    with rotated_shape <- Shape.rotate(active_shape),
         coordinates <- {offset_x, offset_y},
         {:ok, coordinates} <- Rules.validate_shape_position(board, rotated_shape, coordinates),
         {:ok, coordinates} <- Rules.detect_colission(board, rotated_shape, coordinates),
         {:ok, updated_game} <- Rules.not_touches_ground(board, rotated_shape, coordinates),
         {:ok, _} <- Rules.gravity_pull?(board, rotated_shape, coordinates)
      do
      %Game{game | active_shape: rotated_shape}
      else
        {:error, :outside} -> game
      {:error, :tile_present} -> game
        {:error, :touches_ground} -> move_for_touched_ground(game, Shape.rotate(active_shape), {offset_x, offset_y})
        # {:error, :lane_matured} -> step_for_lane_matured(game)
      # {:error, :tile_below} -> step_for_tile_below(game, rotated_shape, {offset_x - 1, offset_y})
    end
  end

  #
  def move(%Game{ offset_x: offset_x,
                  offset_y: offset_y,
                  active_shape: shape,
                  board: board
                } = game, :left) do
    with u_coordinates <- { offset_x - 1, offset_y},
         {:ok, coordinates} <- Rules.validate_shape_position(board, shape, u_coordinates),
         {:ok, coordinates} <- Rules.detect_colission(board, shape, u_coordinates)
    # {:ok, updated_game} <- Rules.not_touches_ground(board, shape, u_coordinates)
    # {:ok, _} <- Rules.gravity_pull?(board, shape, u_coordinates)
    # {:ok, no_lane_matured} <- Rules.no_lane_matures(board, shape, u_coordinates)
      do
      {u_offset_x, u_offset_y} = u_coordinates
      %Game{game | offset_x: u_offset_x, offset_y: u_offset_y}
      else
        {:error, :outside} -> game
      {:error, :tile_present} -> game
        # {:error, :touches_ground} -> move_for_touched_ground(game)
        {:error, :lane_matured} -> step_for_lane_matured(game)
      # {:error, :tile_below} -> step_for_tile_below(game, {offset_x - 1, offset_y})
    end
  end


  defp step_for_tile_below(game, shape, {offset_x, offset_y} = coordinates) do
    {:ok, b_w_s} = BoardManager.add(game.board, game.active_shape, coordinates)
    lanes = Rules.lanes_matured_with_shape_at(b_w_s, shape, coordinates)

    if length(lanes) == 0 do
      %Game{ game |
             offset_x: 5,
             offset_y: 1,
             active_shape: game.next_shape,
             next_shape: Shape.new_random(),
             board: b_w_s
      }
    else

      # IO.puts "lane matured....."
      # IO.puts inspect(lanes)
      # IO.puts "matured lanes..."

      %Game{ game |
             offset_x: 5,
             offset_y: 1,
             active_shape: game.next_shape,
             next_shape: Shape.new_random(),
             # board: b_w_s
             board: BoardManager.remove_lanes_from_board(b_w_s, lanes)
      }

    end
  end

  #
  defp move_for_touched_ground(game, shape, {offset_x, offset_y} = coordinates) do
    {:ok, b_w_s} = BoardManager.add(game.board, game.active_shape, coordinates)

    lanes = Rules.lanes_matured_with_shape_at(b_w_s, shape, coordinates)

    if length(lanes) == 0 do
      %Game{ game |
             offset_x: 5,
             offset_y: 1,
             active_shape: game.next_shape,
             next_shape: Shape.new_random(),
             board: b_w_s
      }
    else

      IO.puts "lane matured....."
      IO.puts inspect(lanes)
      IO.puts "matured lanes..."


      %Game{ game |
             offset_x: 5,
             offset_y: 1,
             active_shape: game.next_shape,
             next_shape: Shape.new_random(),
             board: b_w_s
      }

    end

      # else
    # {:error, message} -> game
    # %Game{ game |
    #                         offset_x: 5,
    #                         offset_y: 1,
    #                         active_shape: game.next_shape,
    #                         next_shape: Shape.new_random(),
    #                         board: board
    #                         }
    # {:error, abc}
  end

  defp step_for_lane_matured(game) do
    game
  end

  def move(%Game{ offset_x: offset_x,
                  offset_y: offset_y,
                  active_shape: shape,
                  board: board
                } = game, :right) do
    with u_coordinates <- { offset_x + 1, offset_y},
         {:ok, coordinates} <- Rules.validate_shape_position(board, shape, u_coordinates),
         {:ok, coordinates} <- Rules.detect_colission(board, shape, u_coordinates)
    # {:ok, updated_game} <- Rules.not_touches_ground(board, shape, u_coordinates)
    # {:ok, _} <- Rules.gravity_pull?(board, shape, u_coordinates)
    # {:ok, updated_game} <- Rules.touches_ground(board, shape, u_coordinates)
    # {:ok, no_lane_matured} <- Rules.no_lane_matures(board, shape, u_coordinates)
      do
      {u_offset_x, u_offset_y} = u_coordinates
      %Game{game | offset_x: u_offset_x, offset_y: u_offset_y}
      else
        {:error, :outside} -> game
      {:error, :tile_present} -> game
        # {:error, :touches_ground} -> move_for_touched_ground(game)
        {:error, :lane_matured} -> step_for_lane_matured(game)
      # {:error, :tile_below} -> step_for_tile_below(game, shape, {offset_x + 1, offset_y})
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
         {:ok, updated_game} <- Rules.not_touches_ground(board, shape, u_coordinates),
         {:ok, _} <- Rules.gravity_pull?(board, shape, u_coordinates)
      do
      {u_offset_x, u_offset_y} = u_coordinates
      %Game{game | offset_x: u_offset_x, offset_y: u_offset_y}
      else
        {:error, :outside} -> game
      {:error, :tile_present} -> game
        {:error, :touches_ground} -> move_for_touched_ground(game, shape, {offset_x, offset_y + 1})
      # {:error, :lane_matured} -> step_for_lane_matured(game)
      {:error, :tile_below} -> step_for_tile_below(game, shape, {offset_x, offset_y + 1})
    end
  end

  # def move(game, move_direction) do
  #   # score
  #   # active_shape
  #   # next_shape
  #   # board
  #   game
  # end

end
