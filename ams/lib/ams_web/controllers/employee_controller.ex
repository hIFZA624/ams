defmodule AmsWeb.EmployeeController do
  use AmsWeb, :controller

  alias Ams.Payroll
  alias Ams.Payroll.Employee

  #starting action of controller
  def index(conn, _params) do
    employees = Payroll.list_employees()
    render(conn, "index.html", employees: employees)
  end
#new form for create employee
  def new(conn, _params) do
    changeset = Payroll.change_employee(%Employee{})
    render(conn, "new.html", changeset: changeset)
  end

#create employee post action method
  def create(conn, %{"employee" => employee_params}) do
    case Payroll.create_employee(employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Employee created successfully.")
        |> redirect(to: Routes.employee_path(conn, :show, employee))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
 #show employee
  def show(conn, %{"id" => id}) do
    employee = Payroll.get_employee!(id)
    render(conn, "show.html", employee: employee)
  end
  #open a form for edit employee
  def edit(conn, %{"id" => id}) do
    employee = Payroll.get_employee!(id)
    changeset = Payroll.change_employee(employee)
    render(conn, "edit.html", employee: employee, changeset: changeset)
  end

  #update post employee
  def update(conn, %{"id" => id, "employee" => employee_params}) do
    employee = Payroll.get_employee!(id)
    case Payroll.update_employee(employee, employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Employee updated successfully.")
        |> redirect(to: Routes.employee_path(conn, :show, employee))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", employee: employee, changeset: changeset)
    end
  end

  #delete employee
  def delete(conn, %{"id" => id}) do
    employee = Payroll.get_employee!(id)
    {:ok, _employee} = Payroll.delete_employee(employee)
    conn
    |> put_flash(:info, "Employee deleted successfully.")
    |> redirect(to: Routes.employee_path(conn, :index))
  end
end
