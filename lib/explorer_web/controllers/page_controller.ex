defmodule ExplorerWeb.PageController do
  use ExplorerWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def accessibility(conn, _params) do
    render(conn, :accessibility, page_title: "Accessibility")
  end

  def contact(conn, _params) do
    render(conn, :contact, page_title: "Contact")
  end

  def legal_notice(conn, _params) do
    render(conn, :legal_notice, page_title: "Legal Notice")
  end

  def privacy(conn, _params) do
    render(conn, :privacy, page_title: "Privacy")
  end

  def terms(conn, _params) do
    render(conn, :terms, page_title: "Terms of Use")
  end
end
