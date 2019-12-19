defmodule Tetris.Boundary.GameSession do
  use GenServer

  alias Tetris.Core.{Board, Shape, Game}


  def init(_) do

    # dummy game with a few tiles occupied
    game = Game.new(%{})
    shape = Shape.new(:l_shape)
    custom_position_coordinates = {2, 5}
    shape_added_board = Board.add_shape(game.board, shape, custom_position_coordinates)
    game = %Game{game | board: shape_added_board}

    {:ok, game}
  end

  def handle_call(:get_state, _from, game_state) do
    {:reply, game_state}
  end

  def handle_call({:rotate}, _from, game_state) do
  end

  def handle_call({:move, direction}, _from, game_state) do
  end

  # terminate game
  def stop do
  end

end
