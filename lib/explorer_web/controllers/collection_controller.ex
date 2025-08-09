defmodule ExplorerWeb.CollectionController do
  use ExplorerWeb, :controller

  alias Explorer.Repo
  alias Explorer.Collection

  def index(conn, _params) do
    collections = Repo.all(Collection)
    count = length(collections)
    changeset = Collection.changeset(%Collection{}, %{name: "New one", description: "My description"})

    render(conn, :index, page_title: "Collections", collections: collections, count: count, changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    collection = Repo.get(Collection, id)

    render(conn, :show, page_title: collection.name, collection: collection)
  end

  def new(conn, _params) do
    changeset = Collection.changeset(%Collection{}, %{name: "New one", description: "My description"})

    render(conn, :new, page_title: "New collection", changeset: changeset)
  end
end
