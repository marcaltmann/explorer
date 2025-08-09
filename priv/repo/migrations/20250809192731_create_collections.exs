defmodule Explorer.Repo.Migrations.CreateCollections do
  use Ecto.Migration

  def change do
    create table(:collections) do
      add :name, :string
      add :description, :text

      timestamps(type: :utc_datetime)
    end
  end
end
