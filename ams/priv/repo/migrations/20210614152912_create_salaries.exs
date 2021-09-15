defmodule Ams.Repo.Migrations.CreateSalaries do
  use Ecto.Migration

  def change do
    create table(:salaries) do
      add :month, :date
      add :short_leaves, :integer
      add :half_leaves, :integer
      add :full_leaves, :string
      add :over_time, :float
      add :deductions, :float
      add :advance, :float
      add :current_salary, :float
      add :calculated_salary, :float
      add :notes, :text
      add :paid_on, :utc_datetime
      add :paid_via, :string
      add :paid_to, :string
      add :employee_id, references(:employees, on_delete: :nothing)

      timestamps()
    end

    create index(:salaries, [:employee_id])
  end
end
