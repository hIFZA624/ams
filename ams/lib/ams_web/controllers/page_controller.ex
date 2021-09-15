defmodule AmsWeb.PageController do
  use AmsWeb, :controller
  def index(conn, _params) do
    conn |> redirect(to: "/login")
  end
end
