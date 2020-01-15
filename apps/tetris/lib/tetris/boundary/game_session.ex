defmodule Tetris.Boundary.GameSession do
  use GenServer

  alias Tetris.Core.{Board, Shape, Game}
  alias Tetris.Boundary.{GameLogic, BoardManager}


  def init(opts) do
    game = Game.new(opts)
    Process.send_after(self(), :tick, 500)
    {:ok, game}
  end

  def handle_call(:get_state, _from, game_state) do
    {:reply, game_state}
  end

  def handle_call(:rotate, _from, game_state) do
    state_after_move = GameLogic.rotate(game_state)
    notify_game_changed(game_state, state_after_move)

    {:reply,"rotated" , state_after_move }
  end

  def handle_call({:move, direction}, _from, game_state) do
    after_move = GameLogic.move(game_state, direction)
    notify_game_changed(game_state, after_move)
    {:reply, "moved", after_move}
  end

  # terminate game
  def stop do
  end

  def handle_info(:tick, game_state) do
    state_after_move = GameLogic.move(game_state, :gravity)

    if state_after_move.current_state == :game_over do
      IO.puts "Game Over..."
    else
      Process.send_after(self(), :tick, 500)
    end
    notify_game_changed(state_after_move, state_after_move)
    {:noreply, state_after_move}
  end

  defp notify_game_changed(state, next_state) do
    state_change_listener = state.state_change_listener
    Process.send(state_change_listener, {:state_change, next_state}, [])
    :ok
  end

end
