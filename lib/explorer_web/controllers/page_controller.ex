defmodule ExplorerWeb.PageController do
  use ExplorerWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def contact(conn, _params) do
    render(conn, :contact)
  end

  def accessibility(conn, _params) do
    render(conn, :accessibility)
  end
end
