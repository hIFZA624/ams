defmodule Ams.Payroll.Department do
  use Ecto.Schema
  import Ecto.Changeset

  schema "departments" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(department, attrs) do
    department
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
