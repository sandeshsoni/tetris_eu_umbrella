defmodule Tetris.Core.Game do
  alias Tetris.Core.{Board, Shape}

  defstruct ~w[
    state_change_listener
    current_state
    active_shape
    next_shape
    board
    score
    game_shapes
    game_over
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
                  board: Board.new(Map.get(opts, :width, 50), Map.get(opts, :height, 50)),
                  offset_x: 15,
                  offset_y: 5,
                  active_shape: Shape.new(:s_shape),
                  next_shape: Shape.new(:l_shape),
                  current_state: :initiated
                }
    struct(__MODULE__, Map.merge(def_opts, opts))
  end

end
