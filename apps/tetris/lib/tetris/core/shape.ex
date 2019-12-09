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

  def move_left(%__MODULE__{offset_x: old_offset_x} = shape) do
    %__MODULE__{ shape | offset_x: (old_offset_x - 1)
    }
  end

  def move_right(%__MODULE__{offset_x: old_offset_x} = shape) do
    %__MODULE__{ shape | offset_x: (old_offset_x + 1)
    }
  end

  def move_down(%__MODULE__{offset_y: old_offset_y} = shape) do
    %__MODULE__{ shape | offset_y: (old_offset_y + 1)
    }
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
  # def new(:l_shape, starting_point_x \\ 0, starting_point_y \\ 0) do
  def new(:l_shape, starting_point_x, starting_point_y) do
    %__MODULE__{
      coordinates: MapSet.new([ {0,0},
                     {0,1},
                     {0,2},{1,2}
                   ]),
      length: 2,
      offset_x: starting_point_x,
      offset_y: starting_point_y
    }
  end

  def new(:s_shape, starting_point_x, starting_point_y) do
    %__MODULE__{
      coordinates: MapSet.new([{2,1}, {3,1}, {1,2}, {2,2}]),
      length: 2,
      offset_x: starting_point_x,
      offset_y: starting_point_y,
      color: :blue
    }
  end

  def with_offset_counted(%__MODULE__{offset_x: shape_offset_x, offset_y: shape_offset_y, coordinates: coordinates} = _shape) do
    Enum.map(coordinates, fn {x,y} -> {x + shape_offset_x, y + shape_offset_y} end)
  end

  # coordinate {x,y}
  # x, y. from 0,0
  # * t *
  # t t t
  # * * *
  # t - shape
  def new(:t_shape, starting_point_x, starting_point_y) do
    %__MODULE__{
      coordinates: MapSet.new([ {1,0},
                     {0,1},{1,1},{2,1}
                   ]),
      length: 2,
      offset_x: starting_point_x,
      offset_y: starting_point_y
    }
  end

  def new(shape, starting_point_x \\ 0, starting_point_y \\ 0) do
  end

end
