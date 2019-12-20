defmodule Tetris.Boundary.GameLogic do
  alias Tetris.Core.{Board, Shape, Game}
  alias Tetris.Boundary.{Rules}

  def rotate(%Game{ offset_x: offset_x,
                    offset_y: offset_y,
                    active_shape: active_shape,
                    board: board
                  } = game) do

    IO.puts "rotate called"

    rotated_shape = active_shape
    %Game{game | active_shape: rotated_shape}
  end

  #
  def move(%Game{ offset_x: offset_x,
                  offset_y: offset_y,
                  active_shape: active_shape,
                  board: board
                } = game, :left) do

    {u_offset_x, u_offset_y} = case Rules.shape_outside_board?(board, active_shape, {offset_x - 1, offset_y}) do
                                 false -> {(offset_x - 1) , offset_y}
                                 true -> {offset_x, offset_y}
                               end

    %Game{game | offset_x: u_offset_x}
  end

  def move(%Game{ offset_x: offset_x,
                  offset_y: offset_y,
                  active_shape: active_shape,
                  board: board
                } = game, :right) do

    {u_offset_x, u_offset_y} = case Rules.shape_outside_board?(board, active_shape, {offset_x - 1, offset_y}) do
                                 false -> {(offset_x + 1) , offset_y}
                                 true -> {offset_x, offset_y}
                               end

    %Game{game | offset_x: u_offset_x}
  end

  def move(%Game{ offset_x: offset_x,
                  offset_y: offset_y,
                  active_shape: active_shape,
                  board: board
                } = game, :down) do

    {u_offset_x, u_offset_y} = case Rules.shape_outside_board?(board, active_shape, {offset_x, offset_y + 1}) do
                                 false -> {(offset_x) , offset_y + 1}
                                 true -> {offset_x, offset_y}
                               end
    %Game{game | offset_y: u_offset_y}
  end

  def move(game, move_direction) do
    # score
    # active_shape
    # next_shape
    # board
    game
  end

end
