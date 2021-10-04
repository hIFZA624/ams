defmodule Associations.Repo.Migrations.AddEmptyTable do
  use Ecto.Migration

  def change do
    create table(:empty) do
      add :use, :string
      add :no, :string
  end
end
end
