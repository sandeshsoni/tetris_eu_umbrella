defmodule Tetris.Shape_test do
  use ExUnit.Case
  alias Tetris.Core.{Shape}

  describe "new shapes" do

    test "new" do
      shape = Shape.new(:l_shape)
      assert shape.coordinates == MapSet.new([{0,0},{0,1},{0,2},{1,2}])
    end
  end

  describe "rotations" do

    # l * *
    # l * *
    # l l *
    # L - shape
    test "just rotate l shape" do
      shape = Shape.new(:l_shape)

      assert Shape.rotate(shape).coordinates == MapSet.new([{0,0},{1,0},{2,0},{0,1}])
    end
  end

  describe "rotate 4 times is original shape" do

    test "L shape" do
      shape = Shape.new(:l_shape)
      rotate_4_times = shape
      |> Shape.rotate
      |> Shape.rotate
      |> Shape.rotate
      |> Shape.rotate

      assert shape.coordinates == rotate_4_times.coordinates
    end

    test "S shape" do
      shape = Shape.new(:s_shape)
      rotate_4_times = shape
      |> Shape.rotate
      |> Shape.rotate
      |> Shape.rotate
      |> Shape.rotate

      assert shape.coordinates == rotate_4_times.coordinates
    end

  end


  test "rotate at boundary" do
    #
  end

end
