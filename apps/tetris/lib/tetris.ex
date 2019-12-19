defmodule Tetris do

  alias Tetris.Boundary.{GameSession}

  @moduledoc """
  Documentation for Tetris.
  """

  def start_game_session do
    # GenServer.start_link(GameManager, %{}, name: GameManager)
    GenServer.start_link(GameSession, %{})
  end

  def move(session, direction) do
    # GenServer.handle_call(session, {:move, direction})
    GameSession.handle_call(session, {:move, direction})
  end

  def rotate(session) do
    GameSession.handle_call(session, :rotate)
  end

end
