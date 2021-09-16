defmodule Ams.Payroll.EmployeeAdmin do
  alias Ams.Payroll
  import Ecto.Query
  alias Ams.Accounts
  alias Ams.Payroll.Employee

  def custom_index_query(_conn, _schema, query) do
    from(r in query, preload: [:department])
  end
  def index(_) do
    [
      id: nil,
      name: nil,
      current_designation: nil,
      current_salary: nil,
      email: nil,
      joining_date: nil,
      department_id: %{ name: "Department",value: fn p -> p.department.name end,filters: Enum.map(Payroll.list_departments(),fn d->{d.name,d.id} end)}
    ]
  end
end
