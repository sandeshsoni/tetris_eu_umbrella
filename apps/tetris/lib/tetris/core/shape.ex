defmodule Tetris.Core.Shape do

  defstruct ~w[
    tiles
    coordinates
    offset_x
    offset_y
    color
    length
  ]a

  # rotate
  def rotate(%__MODULE__{coordinates: coordinates,
                         length: length
                        } = shape) do
    new_coords = coordinates
        |> Enum.map(fn{x, y} -> {length - y, x} end)

    %__MODULE__{ shape | coordinates: MapSet.new(new_coords) }
  end

  def move(shape) do
  end

  def new_random do
    [:l_shape, :s_shape]
    |> Enum.random
    |> new
  end

  # coordinate {x,y}
  # x, y. from 0,0
  # l * *
  # l * *
  # l l *
  # L - shape
  def new(:l_shape) do
    %__MODULE__{
      coordinates: MapSet.new([ {0,0},
                     {0,1},
                     {0,2},{1,2}
                   ]),
      length: 2
    }
  end

  def new(:s_shape) do
    %__MODULE__{
      coordinates: MapSet.new([{2,1}, {3,1}, {1,2}, {2,2}]),
      length: 3
    }
  end

  def with_offset_counted(shape) do
    #
  end

  # coordinate {x,y}
  # x, y. from 0,0
  # * t *
  # t t t
  # * * *
  # t - shape
  def new(:t_shape) do
    %__MODULE__{
      coordinates: MapSet.new([ {1,0},
                     {0,1},{1,1},{2,1}
                   ]),
      length: 3
    }
  end

end
