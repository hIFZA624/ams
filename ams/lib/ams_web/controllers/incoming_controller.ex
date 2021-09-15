defmodule AmsWeb.IncomingController do
  use AmsWeb, :controller

  alias Ams.Income
  alias Ams.Income.Incoming

  def index(conn, _params) do
    incomings = Income.list_incomings()
    render(conn, "index.html", incomings: incomings)
  end

  def new(conn, _params) do
    changeset = Income.change_incoming(%Incoming{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"incoming" => incoming_params}) do
    case Income.create_incoming(incoming_params) do
      {:ok, incoming} ->
        conn
        |> put_flash(:info, "Incoming created successfully.")
        |> redirect(to: Routes.incoming_path(conn, :show, incoming))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    incoming = Income.get_incoming!(id)
    render(conn, "show.html", incoming: incoming)
  end

  def edit(conn, %{"id" => id}) do
    incoming = Income.get_incoming!(id)
    changeset = Income.change_incoming(incoming)
    render(conn, "edit.html", incoming: incoming, changeset: changeset)
  end

  def update(conn, %{"id" => id, "incoming" => incoming_params}) do
    incoming = Income.get_incoming!(id)

    case Income.update_incoming(incoming, incoming_params) do
      {:ok, incoming} ->
        conn
        |> put_flash(:info, "Incoming updated successfully.")
        |> redirect(to: Routes.incoming_path(conn, :show, incoming))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", incoming: incoming, changeset: changeset)
    end
  end
  def delete(conn, %{"id" => id}) do
    incoming = Income.get_incoming!(id)
    {:ok, _incoming} = Income.delete_incoming(incoming)
    conn
    |> put_flash(:info, "Incoming deleted successfully.")
    |> redirect(to: Routes.incoming_path(conn, :index))
  end
end
