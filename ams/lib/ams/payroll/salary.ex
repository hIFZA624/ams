defmodule Ams.Payroll.Salary do
  use Ecto.Schema
  import Ecto.Changeset

  schema "salaries" do
    field :advance, :float
    field :calculated_salary, :float
    field :current_salary, :float
    field :deductions, :float
    field :full_leaves, :string
    field :half_leaves, :integer
    field :month, :date
    field :notes, :string
    field :over_time, :float
    field :paid_on, :utc_datetime
    field :paid_to, :string
    field :paid_via, :string
    field :short_leaves, :integer
    belongs_to :employee, Ams.Payroll.Employee
    timestamps()
  end

  @doc false
  def changeset(salary, attrs) do
    salary
    |> cast(attrs, [:month, :short_leaves, :half_leaves, :full_leaves,:employee_id, :over_time, :deductions, :advance, :current_salary, :calculated_salary, :notes, :paid_on, :paid_via, :paid_to])
    |> validate_required([:month, :short_leaves, :half_leaves, :full_leaves, :over_time, :deductions, :advance, :current_salary, :calculated_salary, :notes, :paid_on, :paid_via, :paid_to])
  end
end
