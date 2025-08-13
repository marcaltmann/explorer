defmodule ExplorerWeb.EditorController do
  use ExplorerWeb, :controller
  alias Explorer.Repo
  alias Explorer.Collection

  def home(conn, _params) do
    render(conn, :home, page_title: "Editor")
  end

  def collections(conn, _params) do
    collections = Repo.all(Collection)
    count = length(collections)
    render(conn, :collections, page_title: "Collections", collections: collections, count: count)
  end

  def collection_detail(conn, %{"id" => id}) do
    collection = Repo.get(Collection, id)
    render(conn, :collection_detail, page_title: collection.name, collection: collection)
  end
end
