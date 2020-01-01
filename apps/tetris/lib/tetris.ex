defmodule Tetris do

  alias Tetris.Boundary.{GameSession}

  @moduledoc """
  Documentation for Tetris.
  """

  def start_game_session(args) do
    # GenServer.start_link(GameManager, %{}, name: GameManager)
    GenServer.start_link(GameSession, %{state_change_listener: args.listener_pid, width: 20, height: 20})
  end

  def move(session, direction) do
    # GenServer.handle_call(session, {:move, direction})
    GenServer.call(session, {:move, direction})
  end

  def rotate(session) do
    GenServer.call(session, :rotate)
  end

end
