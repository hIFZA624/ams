defmodule Ams.Payroll.EmployeeAdmin do
  alias Ams.Payroll
  import Ecto.Query
  alias Ams.Accounts
  alias Ams.Payroll.Employee

  def index(_) do
    [
      id: nil,
      name: nil,
      current_designation: nil,
      current_salary: nil,
      email: nil,
      joining_date: nil,

      department_id: %{filters: Enum.map(Payroll.list_departments(),fn d->{d.name,d.id} end)}
    ]
  end
end
