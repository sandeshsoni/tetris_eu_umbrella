defmodule Tetris.Boundary.GameSession do
  use GenServer

  def init({}) do
  end

  def handle_call({:rotate}, _from, game_state) do
  end

  def handle_call({:move, direction}, _from, game_state) do
  end

  # terminate game
  def stop do
  end

end
