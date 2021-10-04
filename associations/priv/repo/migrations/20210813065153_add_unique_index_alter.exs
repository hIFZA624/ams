defmodule Associations.Repo.Migrations.AddUniqueIndexAlter do
  use Ecto.Migration

  def change do
    drop index("avatars", [:user_id])
  end
end
