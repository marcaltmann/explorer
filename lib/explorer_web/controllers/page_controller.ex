defmodule ExplorerWeb.PageController do
  use ExplorerWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def accessibility(conn, _params) do
    render(conn, :accessibility)
  end

  def contact(conn, _params) do
    render(conn, :contact)
  end

  def legal_notice(conn, _params) do
    render(conn, :legal_notice)
  end

  def privacy(conn, _params) do
    render(conn, :privacy)
  end

  def terms(conn, _params) do
    render(conn, :terms)
  end
end
