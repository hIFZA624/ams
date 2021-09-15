defmodule AmsWeb.DistributionController do
  use AmsWeb, :controller

  alias Ams.Income
  alias Ams.Income.Distribution

  def index(conn, _params) do
    distributions = Income.list_distributions()
    render(conn, "index.html", distributions: distributions)
  end

  def new(conn, _params) do
    changeset = Income.change_distribution(%Distribution{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"distribution" => distribution_params}) do
    case Income.create_distribution(distribution_params) do
      {:ok, distribution} ->
        conn
        |> put_flash(:info, "Distribution created successfully.")
        |> redirect(to: Routes.distribution_path(conn, :show, distribution))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
  def show(conn, %{"id" => id}) do
    distribution = Income.get_distribution!(id)
    render(conn, "show.html", distribution: distribution)
  end

  def edit(conn, %{"id" => id}) do
    distribution = Income.get_distribution!(id)
    changeset = Income.change_distribution(distribution)
    render(conn, "edit.html", distribution: distribution, changeset: changeset)
  end

  def update(conn, %{"id" => id, "distribution" => distribution_params}) do
    distribution = Income.get_distribution!(id)
    case Income.update_distribution(distribution, distribution_params) do
      {:ok, distribution} ->
        conn
        |> put_flash(:info, "Distribution updated successfully.")
        |> redirect(to: Routes.distribution_path(conn, :show, distribution))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", distribution: distribution, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    distribution = Income.get_distribution!(id)
    {:ok, _distribution} = Income.delete_distribution(distribution)

    conn
    |> put_flash(:info, "Distribution deleted successfully.")
    |> redirect(to: Routes.distribution_path(conn, :index))
  end
end
