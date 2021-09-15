defmodule AmsWeb.SpendingController do
  use AmsWeb, :controller

  alias Ams.Expense
  alias Ams.Expense.Spending

  def index(conn, _params) do
    spendings = Expense.list_spendings()
    render(conn, "index.html", spendings: spendings)
  end

  def new(conn, _params) do
    changeset = Expense.change_spending(%Spending{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"spending" => spending_params}) do
    case Expense.create_spending(spending_params) do
      {:ok, spending} ->
        conn
        |> put_flash(:info, "Spending created successfully.")
        |> redirect(to: Routes.spending_path(conn, :show, spending))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    spending = Expense.get_spending!(id)
    render(conn, "show.html", spending: spending)
  end

  def edit(conn, %{"id" => id}) do
    spending = Expense.get_spending!(id)
    changeset = Expense.change_spending(spending)
    render(conn, "edit.html", spending: spending, changeset: changeset)
  end

  def update(conn, %{"id" => id, "spending" => spending_params}) do
    spending = Expense.get_spending!(id)

    case Expense.update_spending(spending, spending_params) do
      {:ok, spending} ->
        conn
        |> put_flash(:info, "Spending updated successfully.")
        |> redirect(to: Routes.spending_path(conn, :show, spending))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", spending: spending, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    spending = Expense.get_spending!(id)
    {:ok, _spending} = Expense.delete_spending(spending)
    conn
    |> put_flash(:info, "Spending deleted successfully.")
    |> redirect(to: Routes.spending_path(conn, :index))
  end
end
