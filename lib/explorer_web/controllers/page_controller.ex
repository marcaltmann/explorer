defmodule ExplorerWeb.PageController do
  use ExplorerWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
