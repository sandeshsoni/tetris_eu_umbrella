defmodule  ElixirconfEuWeb.Tetris.Index do
  use Phoenix.LiveView
  # alias Tetris.{Tile, Game, Shape}
  alias Tetris.Core.{Board, Game, Shape}

  def mount(_session, socket) do
    # if connected?(socket), do: Process.send_after(self(), :tick, 1000)
    # Let GenServe do this part.
    {:ok, initial_state(socket)}
  end

  defp initial_state(socket) do
    game = Game.new()

    assign(socket,
      # game: game,
      game_over: game.game_over,
      board: game.board,
      active_shape: game.active_shape,
      score: game.score,
      game_over: game.game_over,
      shape_names: game.shape_names,
      # board: game.board,
      player_name: "somebody",
      new_game: true,
      speed: 600
    )
  end

  defp restart_game(socket, game_mode) do
    game = Game.new(game_mode)

    assign(socket,
      # game: game,
      score: game.score,
      game_over: game.game_over
      # board: game.board,
    )
  end

  def render(%{new_game: true} = assigns) do
    # Phoenix.LiveView.live_render("tetris_game.html")
    LiveViewDemoWeb.TetrisView.render("tetris-welcome.html", assigns)
  end

  # def render(%{tetris: true} = assigns) do
  def render(%{game_over: true} = assigns) do
    ~L"""
    <div class="tetris-container">

    <div>

    <h1 style="color: red">
    Game Over !!!
    Your score was <%= @score %>
    </h1>
    <br/>


    <div class="tetris options">
    <button phx-click="tetris-new-game" phx-value-mode="classic">New Classic Game</button>
    <button phx-click="tetris-new-game" phx-value-mode="evil">New Evil Game</button>
    </div>

    </div>

    </div>
    """

  end
  def render(%{game_over: false} = assigns) do
    LiveViewDemoWeb.TetrisView.render("tetris-game.html", assigns)
  end

  def handle_event("game_submit", %{
        "player-name" => player_name,
        "game-mode" => game_mode} = form, socket) do
    mode = String.to_atom(game_mode)
    game = Game.new(mode)

    #config maintaintains game board


    {:noreply,
     assign(socket,
       player_name: player_name,
       board: game.board,
       active_shape: game.active_shape,
       score: game.score,
       # game: game,
       game_over: game.game_over,
       speed: game.speed,
       new_game: false
     )
    }
  end

  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, socket.assigns.speed)

     move_down(socket)
  end

  # # def handle_event("move",  %{"code" => "ArrowUp"}, socket) do
  # # def handle_event("tetris-new-game", value, socket) do
  # def handle_event("tetris-new-game", game_mode, socket) do
  #   IO.puts "------------"
  #   IO.puts inspect(game_mode)
  # end

  def handle_event("tetris-new-game", %{"mode" => game_mode}, socket) do
    return_game = case String.to_atom(game_mode) do
                    :evil -> restart_game(socket, :evil)
                    :classic -> restart_game(socket, :regular)
                    _ -> restart_game(socket, :regular)
                  end
    {:noreply, return_game}
  end

  def handle_event("tetris", "rotate", socket) do
    # console.log("rotate...")
    {:noreply, assign(socket, shape: Shape.rotate(socket.assigns.game.active_shape))}
  end

  def handle_event("tetris", _path, socket) do
    {:noreply, assign(socket, tetris: !socket.assigns.tetris)}
  end

  def handle_event("joystick-move", %{"dir" => direction}, socket) do
    # add strong validation, direction has to be valid

    game = case String.to_atom(direction) do
             :left ->
               Game.move_object(socket.assigns.game, :left)
             :right ->
               Game.move_object(socket.assigns.game, :right)
             :up ->
               Game.rotate_shape(socket.assigns.game)
             :down ->
               Game.move_object(socket.assigns.game, :down)
           end
    {:noreply, assign(socket,
        # game: game
        board: game.board,
        active_shape: game.active_shape,
        score: game.score
      )}
  end

  def handle_event("move", %{"code" =>  "ArrowDown"}, socket) do
    move_down(socket)
  end
  def handle_event("move", %{"code" => arrow_direction}, socket) do

    initial_game = Game.new(%{board: socket.assigns.board,
                 active_shape: socket.assigns.active_shape,
                 shape_names: socket.assigns.shape_names,
                 score: socket.assigns.score
                })

    game =
      case String.to_atom(arrow_direction) do
             # :ArrowLeft -> Game.move_object(initial_game, :left)
             # :ArrowRight -> Game.move_object(initial_game, :right)
             # :ArrowUp -> Game.rotate_shape(initial_game)
             _ -> initial_game
           end

    {:noreply, assign(socket,
        # game: game
        board: game.board,
        score: game.score,
        active_shape: game.active_shape
      )}
  end

  def handle_event(_, _key, socket) do
    {:noreply, socket
    }
  end

  defp move_down(socket, offset \\ 1) do

    game = Game.new(%{board: socket.assigns.board,
                 active_shape: socket.assigns.active_shape,
                 shape_names: socket.assigns.shape_names,
                 score: socket.assigns.score
                })

    # game_state = Game.move_object(game, :down)
    # {
    #   :noreply,
    #   assign(socket,
    #     # game: game_state,
    #     board: game_state.board,
    #     active_shape: game_state.active_shape,
    #     score: game_state.score,
    #     game_over: game_state.game_over
    #   )
    # }

    {:noreply, socket}
  end

end
