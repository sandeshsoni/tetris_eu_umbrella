defmodule Tetris.Core.Game do
  alias Tetris.Core.{Board, Shape}

  defstruct ~w[
    current_state
    active_shape
    next_shape
    board
    score
    offset_x
    offset_y
  ]a

  def new do
    %__MODULE__{
      board: Board.new,
      score: 0
    }
  end

  def new(opts) do
    def_opts = %{ score: 0,
                  active_shape: Shape.new(:s_shape),
                  next_shape: Shape.new(:l_shape),
                  current_state: :initiated
                }
    struct(__MODULE__, Map.merge(def_opts, opts))
  end

end
