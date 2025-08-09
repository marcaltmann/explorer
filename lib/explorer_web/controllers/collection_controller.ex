defmodule ExplorerWeb.CollectionController do
  use ExplorerWeb, :controller

  def index(conn, _params) do
    render(conn, :index, page_title: "Collections")
  end
end
