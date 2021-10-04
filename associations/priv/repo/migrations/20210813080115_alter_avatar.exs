defmodule Associations.Repo.Migrations.AlterAvatar do
  use Ecto.Migration

  def change do
    create unique_index(:avatars, [:user_id])
  end
end
