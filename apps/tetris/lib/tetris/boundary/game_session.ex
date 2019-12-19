defmodule Tetris.Boundary.GameSession do
  use GenServer

  alias Tetris.Core.{Board, Shape, Game}
  alias Tetris.Boundary.{GameLogic}


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
    {:reply,"rotated" ,game_state}
  end

  def handle_call({:move, direction}, from, game_state) do

    # IO.puts "handle call move, from "

    # IO.puts inspect(from)

    # %Game{
    #   board: board,
    #   active_shape: shape,
    #   offset_x: offset_x,
    #   offset_y: offset_y,
    # } = game_state

    # next_state
    after_move = GameLogic.move(game_state, direction)
    require IEx; IEx.pry

    notify_game_changed(game_state, after_move)

    {:reply, "moved",game_state}
  end

  # terminate game
  def stop do
  end

  defp notify_game_changed(state, next_state) do
    game_session_pid = state.game_id

    # IO.puts inspect(state)

    # Process.send(game_session_pid, :state_change, next_state)
    Process.send(game_session_pid, :state_change, next_state)
    :ok
  end

end
