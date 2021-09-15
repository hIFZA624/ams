defmodule Ams.Payroll.SalaryAdmin do
  alias Ams.Payroll
  import Ecto.Query
  alias Ams.Accounts
  alias Ams.Payroll.Employee

  def index(_) do
    [
      id: nil,
 advance: nil,
      calculated_salary: nil,
    current_salary: nil,
    deductions: nil,
      employee_id: %{filters: Enum.map(Payroll.list_employees(),fn e->{e.name,e.id} end)},
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
