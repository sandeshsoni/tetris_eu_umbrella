defmodule TetrisTest.GameTest do
  use ExUnit.Case
  alias Tetris.Core.Game

  describe "Game attributes" do
    test "default attributes" do
      game = Game.new()

      assert Map.has_key?(game, :board)
      assert Map.has_key?(game, :next_shape)
      assert Map.has_key?(game, :score)
      assert Map.has_key?(game, :current_state)
      assert Map.has_key?(game, :active_shape)
    end
  end



end
