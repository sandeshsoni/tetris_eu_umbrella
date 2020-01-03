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
         {:ok, updated_game} <- Rules.not_touches_ground(board, rotated_shape, coordinates)
      do
      %Game{game | active_shape: rotated_shape}
      else
        {:error, :outside} -> game
      {:error, :tile_present} -> game
        {:error, :tile_below} -> game
    end
  end

  def move(%Game{ offset_x: offset_x,
                  offset_y: offset_y,
                  active_shape: shape,
                  board: board
                } = game, :left) do
    with u_coordinates <- { offset_x - 1, offset_y},
         {:ok, coordinates} <- Rules.validate_shape_position(board, shape, u_coordinates),
         {:ok, coordinates} <- Rules.detect_colission(board, shape, u_coordinates)
      do
      {u_offset_x, u_offset_y} = u_coordinates
      %Game{game | offset_x: u_offset_x, offset_y: u_offset_y}
      else
        {:error, :outside} -> game
      {:error, :tile_present} -> game
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


  def declare_game_over(game) do
    %Game{game | current_state: :game_over}
  end


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

      %Game{ game |
             offset_x: 5,
             offset_y: 1,
             active_shape: game.next_shape,
             next_shape: Shape.new_random(),
             board: BoardManager.remove_lanes_from_board(b_w_s, lanes)
      }
    end
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
      do
      {u_offset_x, u_offset_y} = u_coordinates
      %Game{game | offset_x: u_offset_x, offset_y: u_offset_y}
      else
        {:error, :outside} -> game
      {:error, :tile_present} -> game
        # {:error, :touches_ground} -> move_for_touched_ground(game)
        # {:error, :lane_matured} -> step_for_lane_matured(game)
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
         {:ok, updated_game} <- Rules.not_touches_ground(board, shape, u_coordinates)
      do
      {u_offset_x, u_offset_y} = u_coordinates
      %Game{game | offset_x: u_offset_x, offset_y: u_offset_y}
      else
        {:error, :outside} -> game
      {:error, :tile_present} -> game
        {:error, :touches_ground} -> game
    end
  end

  @doc """
  If cannnot move left, right or bottom, i.e tile surround everywhere, declare game over.
  if tile_below, set state game_over and offset_y is 1, over.
  game.gamestate should be :finish
  """
  def move(%Game{ offset_x: offset_x,
                  offset_y: offset_y,
                  active_shape: shape,
                  board: board
                } = game, :gravity) do
    with u_coordinates <- { offset_x, offset_y + 1},
         # {:ok, coordinates} <- Rules.validate_shape_position(board, shape, u_coordinates),
         # {:ok, coordinates} <- Rules.detect_colission(board, shape, u_coordinates),
         {:ok, updated_game} <- Rules.not_touches_ground(board, shape, u_coordinates),
         # {:ok, _} <- Rules.gravity_pull?(board, shape, u_coordinates), when (offset_y < 2),
         {:ok, _} <- Rules.gravity_pull?(board, shape, u_coordinates)
      do
      {u_offset_x, u_offset_y} = u_coordinates
      %Game{game | offset_x: u_offset_x, offset_y: u_offset_y}
      else
        # {:error, :outside} -> game
      # {:error, :tile_present} -> game
        {:error, :touches_ground} -> move_for_touched_ground(game, shape, {offset_x, offset_y + 1})
      # {:error, :lane_matured} -> step_for_lane_matured(game)
      {:error, :tile_below} -> step_for_tile_below(game, shape, {offset_x, offset_y + 1})
        {:error, :game_over} -> declare_game_over(game)
    end
  end

end
