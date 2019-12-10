defmodule TetrisTest.GameLogicTest do
  use ExUnit.Case
  alias Tetris.Core.{Game, Shape, Board}
  alias Tetris.Boundary.{Rules, GameLogic}


  describe "new game started" do

    test "a step" do
      # new Game is a core function,
      # not a boundary

      # GameLogic.new_game()
      #
      # check bounday left
    end

    @tag :skip
    test "bounday right" do
    end

  end

  describe "rotation" do

    @tag :skip
    test "free rotation"
    @tag :skip
    test "when at corner"
    @tag :skip
    test "when colliding with a tile"
  end

  describe "move" do
    @tag :skip
    test "free move"
    @tag :skip
    test "when collides with existing tile on x-axis"
    @tag :skip
    test "when a shape below"
  end

  describe "line matured" do
    @tag :skip
    test "2 lanes matured"
  end

end
