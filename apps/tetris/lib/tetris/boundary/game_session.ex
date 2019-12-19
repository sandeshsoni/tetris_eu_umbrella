defmodule Tetris.Boundary.GameSession do
  use GenServer

  alias Tetris.Core.{Board, Shape, Game}
  alias Tetris.Boundary.{GameLogic}


  def init(opts) do
    # dummy game with a few tiles occupied

    # IO.puts "############ opts"
    # IO.puts inspect(opts)

    # game = Game.new(%{game_id: self()})
    game = Game.new(opts)
    shape = Shape.new(:l_shape)
    custom_position_coordinates = {2, 5}
    shape_added_board = Board.add_shape(game.board, shape, custom_position_coordinates)
    game = %Game{game | board: shape_added_board}

    {:ok, game}
  end

  # def start_link(args) do
  #   GenServer.start_link(__MODULE__, args)
  # end

  def handle_call(:get_state, _from, game_state) do
    {:reply, game_state}
  end

  def handle_call({:rotate}, _from, game_state) do
    {:reply,"rotated" ,game_state}
  end

  def handle_call({:move, direction}, _from, game_state) do

    after_move = GameLogic.move(game_state, direction)

    notify_game_changed(game_state, after_move)

    {:reply, "moved", after_move}
  end

  # terminate game
  def stop do
  end

  defp notify_game_changed(state, next_state) do
    # game_session_pid = state.game_id
    state_change_listener = state.state_change_listener

    Process.send(state_change_listener, {:state_change, next_state}, [])
    :ok
  end

end
