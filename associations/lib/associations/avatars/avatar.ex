defmodule Associations.Avatars.Avatar do
  use Ecto.Schema
  import Ecto.Changeset

  schema "avatars" do
    field :nick_name, :string
    field :pic_url, :string
    belongs_to :user, Associations.Users.User
  end
  @doc false
  def changeset(avatar, attrs) do
    avatar
    |> cast(attrs, [:nick_name, :pic_url, :user_id])
    |> validate_required([:nick_name, :pic_url, :user_id])
    |> unique_constraint(:user_id)
  end
end