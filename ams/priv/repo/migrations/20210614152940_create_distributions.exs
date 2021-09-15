defmodule Ams.Repo.Migrations.CreateDistributions do
  use Ecto.Migration

  def change do
    create table(:distributions) do
      add :amount_pkr, :float
      add :amount_usd, :float
      add :given_on, :date
      add :from, references(:users, on_delete: :nothing)
      add :to, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:distributions, [:to])
    create index(:distributions, [:from])
  end
end
