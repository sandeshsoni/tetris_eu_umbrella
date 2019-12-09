defmodule Tetris.Core.Game do
  alias Tetris.Core.{Board, Shape}

  defstruct ~w[
    current_state
    active_shape
    next_shape
    board
    score
  ]a

  def new do
    %__MODULE__{
      board: Board.new
    }
  end

  # sleep for 300ms and make a next move
  # Engine
  def step do
    # sleep(300)
  end

  def drop do
    # drop and use next shape
  end

end
