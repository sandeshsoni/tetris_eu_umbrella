defmodule Tetris.Core.Shape do

  defstruct ~w[
    coordinates
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

  def new_random do
    [:l_shape, :s_shape, :t_shape]
    |> Enum.random
    |> new
  end

  # coordinate {x,y}
  # x, y. from 0,0
  # l * *
  # l * *
  # l l *
  # L - shape
  # def new(:l_shape, starting_point_x \\ 0, starting_point_y \\ 0) do
  def new(:l_shape) do
    %__MODULE__{
      coordinates: MapSet.new([ {0,0},
                     {0,1},
                     {0,2},{1,2}
                   ]),
      length: 2,
      color: :red
    }
  end

  # {x, y}
  # s * *
  # s s *
  # * s *
  # S - shape
  def new(:s_shape) do
    %__MODULE__{
      coordinates: MapSet.new([{0,0}, {0,1}, {1,1}, {1,2}]),
      length: 2,
      # offset_x: starting_point_x,
      # offset_y: starting_point_y,
      color: :blue
    }
  end

  def with_offset_counted(%__MODULE__{coordinates: coordinates} = _shape, input_offset_x, input_offset_y) do
    Enum.map(coordinates, fn {x,y} -> {x + input_offset_x, y + input_offset_y} end)
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
      length: 2,
      # offset_x: starting_point_x,
      # offset_y: starting_point_y,
      color: :green
    }
  end

  # def new(shape, starting_point_x \\ 0, starting_point_y \\ 0) do
  # end

end
