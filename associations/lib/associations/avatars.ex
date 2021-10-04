defmodule Associations.Avatars do
  import Ecto.Query, warn: false
  alias Associations.Repo

  alias Associations.Users.User
  alias Associations.Posts.Post
  alias Associations.Avatars.Avatar


  # create user
  def create_avatar(user_id,attrs \\ %{}) do
    nickname=attrs["nick_name"]
    pic_url=attrs["pic_url"]
    avatar=%{nick_name: nickname, pic_url: pic_url, user_id: user_id}

    %Avatar{}
    |> Avatar.changeset(avatar)
    |> Repo.insert()
  end


  def get_avatar!(user_id) do
    query= from a in Avatar,
                where: a.user_id==^user_id

    Repo.one(query) |> Repo.preload(:user)
  end

  #delete user
  def delete_avatar(%Avatar{} = avatar) do
    # query=from p in Post,
    # where: p.user_id== ^user.id
    # Repo.delete_all(query)

    Repo.delete(avatar)
  end
  #update user
  def update_avatar(%Avatar{} = avatar, attrs) do
    avatar
    |> Avatar.changeset(attrs)
    |> Repo.update()
  end
end
