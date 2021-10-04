defmodule Associations.Tags.Tag do
   use Ecto.Schema
   import Ecto.Changeset

   schema "tags" do
     field :name, :string
     many_to_many :posts, Associations.Posts.Post, join_through: "posts_tags"
   end
end
