defmodule Ams.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :name, :string
      add :email, :string
      add :current_designation, :string
      add :current_salary, :float
      add :joining_date, :date
      add :department_id, references(:departments, on_delete: :nothing)
      timestamps()
    end
    create index(:employees, [:department_id])
  end
end
