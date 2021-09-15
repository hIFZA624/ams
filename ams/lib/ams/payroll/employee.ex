defmodule Ams.Payroll.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :current_designation, :string
    field :current_salary, :float
    field :email, :string
    field :joining_date, :date
    field :name, :string
    belongs_to :department, Ams.Payroll.Department
    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:name, :email, :current_designation, :current_salary, :joining_date, :department_id])
    |> validate_required([:name, :email, :current_designation, :current_salary, :joining_date])
  end
end
