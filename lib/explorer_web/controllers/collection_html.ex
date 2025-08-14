defmodule ExplorerWeb.CollectionHTML do
  @moduledoc """
  This module contains pages rendered by CollectionController.

  See the `collection_html` directory for all templates available.
  """
  use ExplorerWeb, :html

  embed_templates "collection_html/*"

  attr :collection, Explorer.Collection, required: true

  def collection(assigns) do
    ~H"""
      <li class="card">
        <a href={~p"/collections/#{@collection.id}"} class="card__link"><!--
          --><h3 class="card__heading">{@collection.name}</h3>
          <p class="card__description">{@collection.description}</p>
          <div class="card__meta">
            <span class="card__meta-item">0 items</span>
            <span class="card__meta-item">{Date.to_iso8601(@collection.inserted_at)}</span>
          </div><!--
        --></a>
      </li>
    """
  end
end
