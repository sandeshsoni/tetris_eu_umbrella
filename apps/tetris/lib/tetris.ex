defmodule Tetris do

  alias Tetris.Boundary.{GameSession}

  @moduledoc """
  Documentation for Tetris.
  """

  def start_game_session do
    GenServer.start_link(GameManager, %{}, name: GameManager)
  end

  def move(session, direction) do
    GenServer.handle_call(session, {:move, direction})
  end

end
