defmodule ExplorerWeb.Admin.CollectionController do
  use ExplorerWeb, :controller
  alias Explorer.Repo
  alias Explorer.Collection

  def index(conn, _params) do
    collections = Repo.all(Collection)
    count = length(collections)
    render(conn, :index, page_title: "Collections", collections: collections, count: count)
  end

  def edit(conn, %{"id" => id}) do
    collection = Repo.get(Collection, id)
    changeset = Collection.changeset(collection, %{})

    render(conn, :edit,
      page_title: "Edit #{collection.name}",
      collection: collection,
      changeset: changeset
    )
  end

  def new(conn, _params) do
    changeset = Collection.changeset(%Collection{}, %{})

    render(conn, :new, page_title: "New collection", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    collection = Repo.get(Collection, id)
    render(conn, :show, page_title: collection.name, collection: collection)
  end

  def create(conn, %{"collection" => collection_params}) do
    changeset = Collection.changeset(%Collection{}, collection_params)

    case Repo.insert(changeset) do
      {:ok, collection} ->
        conn
        |> put_flash(:info, "Collection created successfully.")
        |> redirect(to: ~p"/admin/collections/#{collection.id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, page_title: "New collection", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "collection" => collection_params}) do
    collection = Repo.get(Collection, id)
    changeset = Collection.changeset(collection, collection_params)

    case Repo.update(changeset) do
      {:ok, collection} ->
        conn
        |> put_flash(:info, "Collection updated successfully.")
        |> redirect(to: ~p"/admin/collections/#{collection}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit,
          page_title: "Edit #{collection.name}",
          collection: collection,
          changeset: changeset
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    collection = %Collection{id: String.to_integer(id)}

    case Repo.delete(collection) do
      {:ok, _collection} ->
        conn
        |> put_flash(:info, "Collection deleted successfully.")
        |> redirect(to: ~p"/admin/collections")

      {:delete, _changeset} ->
        conn
        |> put_flash(:error, "Collection could not be deleted.")
        |> redirect(to: ~p"/admin/collections/#{id}")
    end

  end
end
