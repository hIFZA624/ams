defmodule AmsWeb.SubCategoryController do
  use AmsWeb, :controller
  alias Ams.Expense
  alias Ams.Expense.SubCategory

  def index(conn, _params) do
    subcategories = Expense.list_subcategories()
    render(conn, "index.html", subcategories: subcategories)
  end
  def new(conn, _params) do
    changeset = Expense.change_sub_category(%SubCategory{})
    render(conn, "new.html", changeset: changeset)
  end
  def create(conn, %{"sub_category" => sub_category_params}) do
    case Expense.create_sub_category(sub_category_params) do
      {:ok, sub_category} ->
        conn
        |> put_flash(:info, "Sub category created successfully.")
        |> redirect(to: Routes.sub_category_path(conn, :show, sub_category))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sub_category = Expense.get_sub_category!(id)
    render(conn, "show.html", sub_category: sub_category)
  end

  def edit(conn, %{"id" => id}) do
    sub_category = Expense.get_sub_category!(id)
    changeset = Expense.change_sub_category(sub_category)
    render(conn, "edit.html", sub_category: sub_category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sub_category" => sub_category_params}) do
    sub_category = Expense.get_sub_category!(id)

    case Expense.update_sub_category(sub_category, sub_category_params) do
      {:ok, sub_category} ->
        conn
        |> put_flash(:info, "Sub category updated successfully.")
        |> redirect(to: Routes.sub_category_path(conn, :show, sub_category))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sub_category: sub_category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sub_category = Expense.get_sub_category!(id)
    {:ok, _sub_category} = Expense.delete_sub_category(sub_category)
    conn
    |> put_flash(:info, "Sub category deleted successfully.")
    |> redirect(to: Routes.sub_category_path(conn, :index))
  end
end
