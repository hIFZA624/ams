defmodule Associations.Repo.Migrations.AddCommentsTable do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :msg, :string
    end
  end
end
