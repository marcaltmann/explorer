defmodule Explorer.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :title, :string
    belongs_to :collection, Explorer.Collection

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:title, :collection_id])
    |> validate_required([:title, :collection_id])
  end
end
