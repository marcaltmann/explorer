defmodule Explorer.Collection do
  use Ecto.Schema
  import Ecto.Changeset

  schema "collections" do
    field :name, :string
    field :description, :string
    has_many :items, Explorer.Item

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> validate_length(:description, min: 5)
    |> validate_length(:description, max: 140)
  end
end
