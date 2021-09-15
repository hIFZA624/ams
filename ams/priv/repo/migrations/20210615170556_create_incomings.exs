defmodule Ams.Repo.Migrations.CreateIncomings do
  use Ecto.Migration

  def change do
    create table(:incomings) do
      add :amount_usd, :float
      add :amount_pkr, :float
      add :inovice, :string
      add :medium, :string
      add :recieved_on, :date
      add :withdrawl_on, :date
      add :client_id, references(:clients, on_delete: :nothing)
      add :recieved_by, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:incomings, [:client_id])
    create index(:incomings, [:recieved_by])
  end
end
