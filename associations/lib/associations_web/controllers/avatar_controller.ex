defmodule AssociationsWeb.AvatarController do
  use AssociationsWeb, :controller
  alias Associations.Posts
  alias Associations.Users
  alias Associations.Comments
  alias Associations.Posts.Post
  alias Associations.Avatars

  # create a comment
  def create(conn, %{"user_id" => user_id, "avatar" => avatar_params}) do
    case Avatars.create_avatar(user_id,avatar_params) do
      {:ok, avatar} ->
        avatar = Avatars.get_avatar!(user_id)
        render(conn, "show.json", avatar: avatar)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "error.json", changeset: changeset)
    end
  end
  #show a post
  def index(conn, %{"user_id" => user_id}) do
    avatar = Avatars.get_avatar!(user_id)
    render(conn, "show.json", avatar: avatar)
  end
  def update(conn, %{"user_id" => user_id,"id" => id, "avatar" => avatar_params}) do
    avatar = Avatars.get_avatar!(user_id)
    case Avatars.update_avatar(avatar, avatar_params) do
      {:ok, avatar} ->
        avatar = Avatars.get_avatar!(user_id)
        render(conn, "show.json", avatar: avatar)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "error.json", changeset: changeset)
    end
  end
  def delete(conn, %{"user_id" => user_id,"id" => comment_id}) do
    avatar = Avatars.get_avatar!(user_id)
    {:ok ,avatar} =Avatars.delete_avatar(avatar)
    avatar = Avatars.get_avatar!(user_id)
    render(conn, "show.json", avatar: avatar)
  end
end