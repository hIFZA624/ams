defmodule Ams.Payroll.SalaryAdmin do
  alias Ams.Payroll
  import Ecto.Query
  alias Ams.Accounts
  alias Ams.Payroll.Employee

  def custom_index_query(_conn, _schema, query) do
    from(r in query, preload: [:employee])
  end
  def index(_) do
    [
      id: nil,
      employee_id: %{ name: "Employee",value: fn p -> p.employee.name end ,filters: Enum.map(Payroll.list_employees(),fn e->{e.name,e.id} end)},
      advance: nil,
      calculated_salary: nil,
      current_salary: nil,
      deductions: nil,

      full_leaves: nil,
      half_leaves: nil,
      month: nil,
      notes: nil,
      over_time: nil,
      paid_on: nil,
      paid_to: nil,
      paid_via: nil,
     short_leaves: nil
    ]
  end
end
