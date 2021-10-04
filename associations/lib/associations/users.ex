defmodule Associations.Users do
  import Ecto.Query, warn: false
  alias Associations.Repo

  alias Associations.Users.User
  alias Associations.Posts.Post

  #list all users
  def list_users do
    Repo.all(User)
  end

# create user
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
  #get user

  def get_user!(id) do
    query= from p in User,
                where: p.id== ^id
    Repo.one(query)
  end
  #delete user
  def delete_user(%User{} = user) do
   # query=from p in Post,
   # where: p.user_id== ^user.id
   # Repo.delete_all(query)
    Repo.delete(user)
  end
  #update user
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
