defmodule ExplorerWeb.EditorController do
  use ExplorerWeb, :controller

  def home(conn, _params) do
    render(conn, :home, page_title: "Editor")
  end
end
