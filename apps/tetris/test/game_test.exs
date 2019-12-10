defmodule TetrisTest.GameTest do
  use ExUnit.Case
  alias Tetris.Core.{Game, Board}

  describe "Game attributes" do
    test "default attributes" do
      game = Game.new()

      assert Map.has_key?(game, :board)
      assert Map.has_key?(game, :next_shape)
      assert Map.has_key?(game, :score)
      assert Map.has_key?(game, :current_state)
      assert Map.has_key?(game, :active_shape)
      assert Map.has_key?(game, :offset_x)
      assert Map.has_key?(game, :offset_y)
    end

    test "new init values" do
      board = Board.new(20, 20)
      game = Game.new(%{board: board})

      assert game.score == 0
      assert game.active_shape != nil
      assert game.next_shape != nil
      assert game.current_state == :initiated
    end

  end



end
