defmodule ExplorerWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use ExplorerWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Renders your app layout.

  This function is typically invoked from every template,
  and it often contains your application menu, sidebar,
  or similar.

  ## Examples

      <Layouts.app flash={@flash}>
        <h1>Content</h1>
      </Layouts.app>

  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current [scope](https://hexdocs.pm/phoenix/scopes.html)"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <div class="site">
      <header class="header">
        <div class="header__inner">
          <div class="">
            <a href="/" class="">
              Explorer
            </a>
          </div>
          <nav class="menu">
            <ul class="menu__list">
              <li class="menu__item">
                <a href={~p"/"}>Collections</a>
              </li>
              <li class="menu__item">
                <a href={~p"/"}>Sign in</a>
              </li>
            </ul>
          </nav>
        </div>
      </header>

      <main class="site__main">
        <div class="container">
          {render_slot(@inner_block)}
        </div>
      </main>

      <footer class="footer">
        <div class="footer__inner">
          <span class="">Media Explorer v{Application.spec(:explorer, :vsn)}</span>

          <nav class="menu">
            <ul class="menu__list">
              <li class="menu__item">
                <a href={~p"/terms"}>Terms of use</a>
              </li>
              <li class="menu__item">
                <a href={~p"/privacy"}>Privacy</a>
              </li>
              <li class="menu__item">
                <a href={~p"/legal-notice"}>Legal notice</a>
              </li>
              <li class="menu__item">
                <a href={~p"/contact"}>Contact</a>
              </li>
              <li class="menu__item">
                <a href={~p"/accessibility"}>Accessibility</a>
              </li>
            </ul>
          </nav>
        </div>
      </footer>
    </div>

    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />
    </div>
    """
  end
end
