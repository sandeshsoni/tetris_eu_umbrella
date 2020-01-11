defmodule  ElixirconfEuWeb.Tetris.Index do
  use Phoenix.LiveView
  alias Tetris.Core.{Board, Game, Shape}

  def mount(_session, socket) do
    {:ok, game_session_pid} = Tetris.start_game_session(%{listener_pid:  self()})

    new_socket = generate_socket_from_state(socket, :sys.get_state(game_session_pid))
    |> assign(:game_id, game_session_pid)

    {:ok, new_socket}
  end

  def handle_info({:state_change, new_state}, socket) do
    {:noreply, generate_socket_from_state(socket, new_state)}
  end

  def handle_event("tetris", "rotate", socket) do
    game_session_id = socket.assigns.game_id
    Tetris.rotate(game_session_id)
    {:noreply, socket}
  end

  def handle_event("move", %{"code" => key}, socket) do
    game_session_id = socket.assigns.game_id

    case key do
      "ArrowRight" -> Tetris.move(game_session_id, :right)
      "ArrowLeft" -> Tetris.move(game_session_id, :left)
      "ArrowUp" -> Tetris.rotate(game_session_id)
      "ArrowDown" -> Tetris.move(game_session_id, :down)
      _ -> nil
    end
    {:noreply, socket}
  end

  defp generate_socket_from_state(socket, game) do

    assign(socket,
      game_over: game.game_over,
      board: game.board,
      active_shape: game.active_shape,
      next_shape: game.next_shape,
      state_change_listener: game.state_change_listener,
      score: game.score,
      game_over: game.game_over,
      offset_x: game.offset_x,
      offset_y: game.offset_y,

      lanes: game.board.lanes,
      indexor: game.board.indexor,

      new_game: true,
      speed: 600
    )

  end

  def render(assigns) do
    ElixirconfEuWeb.TetrisView.render("tetris-game.html", assigns)
  end

end
