defmodule TetrisTest.BoardManagerTest do
  use ExUnit.Case

  alias Tetris.Core.{Game, Shape, Board}
  alias Tetris.Boundary.{Rules, GameLogic, BoardManager}

  setup do
    {:ok, %{
        board_20_20: Board.new(20, 20),
        board_10_10: Board.new(10, 10),
        s_shape: Shape.new(:s_shape),
        t_shape: Shape.new(:t_shape),
     }
    }
  end

  describe "add shape to board" do

    test "with coordinates inside board", game_elements do
      board = game_elements.board_20_20
      shape = game_elements.s_shape
      coordinates = {10, 10}

      {:ok, board_with_shape } = BoardManager.add(board, shape, coordinates)
    end

    test "with x coordinates outside board", game_elements do
      board = game_elements.board_20_20
      shape = game_elements.s_shape
      coordinates = {70, 10}

      {:error, _board_with_shape } = BoardManager.add(board, shape, coordinates)
    end

    test "with y coordinates outside board", game_elements do
      board = game_elements.board_20_20
      shape = game_elements.s_shape
      coordinates = {10, 70}

      {:error, _board_with_shape } = BoardManager.add(board, shape, coordinates)
    end


  end

  test "remove lane from board"


end
