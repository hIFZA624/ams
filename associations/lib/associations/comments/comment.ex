defmodule Associations.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :msg, :string
    belongs_to :post, Associations.Posts.Post
    belongs_to :user, Associations.Users.User
  end
  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:msg, :post_id, :user_id])
    |> validate_required([:msg])
  end
end