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

end
