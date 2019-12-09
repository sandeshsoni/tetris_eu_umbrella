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

    test "rotate at boundary" do
      #
    end

  end

end
