defmodule ExplorerWeb.EditorHTML do
  @moduledoc """
  This module contains pages rendered by EditorController.

  See the `editor_html` directory for all templates available.
  """
  use ExplorerWeb, :html

  embed_templates "editor_html/*"
end
