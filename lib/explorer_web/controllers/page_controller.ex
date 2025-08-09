defmodule ExplorerWeb.PageController do
  use ExplorerWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def collections(conn, _params) do
    render(conn, :collections, page_title: "Collections")
  end

  def accessibility(conn, _params) do
    render(conn, :page, page_title: "Accessibility")
  end

  def contact(conn, _params) do
    render(conn, :page, page_title: "Contact")
  end

  def legal_notice(conn, _params) do
    render(conn, :page, page_title: "Legal Notice")
  end

  def privacy(conn, _params) do
    render(conn, :page, page_title: "Privacy")
  end

  def terms(conn, _params) do
    render(conn, :page, page_title: "Terms of Use")
  end
end
