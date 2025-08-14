defmodule ExplorerWeb.Admin.DashboardController do
  use ExplorerWeb, :controller
  alias Explorer.Repo
  alias Explorer.Collection
  import Ecto.Query

  def home(conn, _params) do
    count = Repo.one(from c in Collection, select: count(c.id))

    render(conn, :home, page_title: "Admin Dashboard", collection_count: count)
  end
end
