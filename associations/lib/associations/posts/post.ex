defmodule Associations.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :header, :string
    field :body, :string
    belongs_to :user, Associations.Users.User
    has_many :comments, Associations.Posts.Post
   # many_to_many :tags, Associations.Tags.Tag, join_through: "posts_tags"
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:header, :body ,:user_id ])
    |> validate_required([:header, :body, :user_id ])
  end
end