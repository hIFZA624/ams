defmodule AssociationsWeb.PageController do
  use AssociationsWeb, :controller
  def index(conn,  _params) do
    render(conn, "index.html")
  end
end
