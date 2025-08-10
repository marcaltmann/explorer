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
    changeset = Collection.changeset(%Collection{}, %{})

    render(conn, :new, page_title: "New collection", changeset: changeset)
  end

  def create(conn, %{"collection" => collection_params}) do
    changeset = Collection.changeset(%Collection{}, collection_params)

    case Repo.insert(changeset) do
      {:ok, collection} ->
        conn
          |> put_flash(:info, "Collection created successfully.")
          |> redirect(to: ~p"/collections/#{collection.id}")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, page_title: "New collection", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    collection = Repo.get(Collection, id)
    changeset = Collection.changeset(collection, %{})

    render(conn, :edit, page_title: "Edit #{collection.name}", collection: collection, changeset: changeset)
  end

  def update(conn, %{"id" => id, "collection" => collection_params}) do
    collection = Repo.get(Collection, id)
    changeset = Collection.changeset(collection, collection_params)
    Repo.update(changeset)

    redirect(conn, to: ~p"/collections/#{collection.id}")
  end

  def delete(conn, %{"id" => id}) do
    %Collection{id: String.to_integer(id)} |> Repo.delete

    redirect(conn, to: ~p"/collections")
  end
end
