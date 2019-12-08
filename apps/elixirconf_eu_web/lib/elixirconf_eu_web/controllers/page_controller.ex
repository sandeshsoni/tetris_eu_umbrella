defmodule ElixirconfEuWeb.PageController do
  use ElixirconfEuWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
