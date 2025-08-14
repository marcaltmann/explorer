defmodule ExplorerWeb.CollectionController do
  use ExplorerWeb, :controller

  alias Explorer.Repo
  alias Explorer.Collection

  def index(conn, _params) do
    collections = Repo.all(Collection)
    count = length(collections)

    render(conn, :index, page_title: "Collections", collections: collections, count: count)
  end

  def show(conn, %{"id" => id}) do
    collection = Repo.get(Collection, id)

    render(conn, :show, page_title: collection.name, collection: collection)
  end
end
