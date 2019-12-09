defmodule Tetris.Core.Game do
  # use GenServer
  # GameEngine has GenServer

  def init(_) do
    game = Tetris.Board.new()

    {:ok, game}
  end

  # sleep for 300ms and make a next move
  # Engine
  def step do
    # sleep(300)
  end

  def rotate do
    # rotate
  end

  def drop do
    # drop and use next shape
  end

end
