defmodule AmsWeb.SalaryController do
  use AmsWeb, :controller

  alias Ams.Payroll
  alias Ams.Payroll.Salary

  def index(conn, _params) do
    salaries = Payroll.list_salaries()
    render(conn, "index.html", salaries: salaries)
  end

  def new(conn, _params) do
    changeset = Payroll.change_salary(%Salary{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"salary" => salary_params}) do
    case Payroll.create_salary(salary_params) do
      {:ok, salary} ->
        conn
        |> put_flash(:info, "Salary created successfully.")
        |> redirect(to: Routes.salary_path(conn, :show, salary))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    salary = Payroll.get_salary!(id)
    render(conn, "show.html", salary: salary)
  end
  def edit(conn, %{"id" => id}) do
    salary = Payroll.get_salary!(id)
    changeset = Payroll.change_salary(salary)
    IO.inspect(changeset)
    render(conn, "edit.html", salary: salary, changeset: changeset)
  end

  def update(conn, %{"id" => id, "salary" => salary_params}) do
    salary = Payroll.get_salary!(id)
    case Payroll.update_salary(salary, salary_params) do
      {:ok, salary} ->
        conn
        |> put_flash(:info, "Salary updated successfully.")
        |> redirect(to: Routes.salary_path(conn, :show, salary))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", salary: salary, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    salary = Payroll.get_salary!(id)
    {:ok, _salary} = Payroll.delete_salary(salary)
    conn
    |> put_flash(:info, "Salary deleted successfully.")
    |> redirect(to: Routes.salary_path(conn, :index))
  end
end
