defmodule Ams.Repo.Migrations.CreateSpendings do
  use Ecto.Migration

  def change do
    create table(:spendings) do
      add :title, :string
      add :amount, :float
      add :spent_on, :date
      add :notes, :text
      add :spent_by, references(:users, on_delete: :nothing)
      add :category_id, references(:subcategories, on_delete: :nothing)

      timestamps()
    end

    create index(:spendings, [:spent_by])
    create index(:spendings, [:category_id])
  end
end
