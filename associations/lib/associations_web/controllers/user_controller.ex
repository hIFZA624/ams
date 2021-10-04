defmodule AssociationsWeb.UserController do
  use AssociationsWeb, :controller

  alias Associations.Users
  alias Associations.Users.User

#show list of all users
  def index(conn, _params) do
    users = Users.list_users()
    IO.inspect(users)
    render(conn, "index.json", users: users)
  end

# create new user
  def create(conn, %{"user" => user_params}) do

  case Users.create_user(user_params) do
    {:ok, user} ->
      users = Users.list_users()
      render(conn, "index.json", users: users)
    {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, "error.json", changeset: changeset)
  end
  end

  # show a user
  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

#update a  user
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)
    case Users.update_user(user, user_params) do
      {:ok, user} ->
        user = Users.get_user!(id)
        render(conn, "show.json", user: user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "error.json", changeset: changeset)
    end
  end

  #delete a  user
  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end
end
