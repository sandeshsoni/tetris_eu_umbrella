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

  describe "move shapes" do

    @tag :skip
    test "move a left to left" do
      starting_point_x = 5
      starting_point_y = 0
      shape = Shape.new(:s_shape, starting_point_x, starting_point_y)

      moved_shape = Shape.move_left(shape)

      assert moved_shape.offset_x == 4
      assert moved_shape.offset_y == 0

    end

    @tag :skip
    test "move once right" do
      starting_point_x = 5
      starting_point_y = 0
      shape = Shape.new(:s_shape, starting_point_x, starting_point_y)

      moved_shape = Shape.move_right(shape)

      assert moved_shape.offset_x == 6
      assert moved_shape.offset_y == 0

    end

    @tag :skip
    test "move once down" do
      starting_point_x = 5
      starting_point_y = 0
      shape = Shape.new(:s_shape, starting_point_x, starting_point_y)

      moved_shape = Shape.move_down(shape)

      assert moved_shape.offset_x == starting_point_x
      assert moved_shape.offset_y == 1

    end

  end


  test "rotate at boundary" do
    #
  end

end
