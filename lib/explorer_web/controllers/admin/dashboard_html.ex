defmodule ExplorerWeb.Admin.DashboardHTML do
  @moduledoc """
  This module contains pages rendered by DashboardController.

  See the `dashboard_html` directory for all templates available.
  """
  use ExplorerWeb, :html

  embed_templates "dashboard_html/*"
end
