defmodule AssociationsWeb.UserView do
  use AssociationsWeb, :view

  def render("index.json", %{users: users}) do
    IO.inspect(users)
    %{data: render_many(users, AssociationsWeb.UserView, "user.json")}
  end

  def render("user.json",%{user: user}) do
    %{name: user.name, email: user.email,id: user.id}
  end

  def render("show.json",%{user: user}) do
    %{data: render_one(user, AssociationsWeb.UserView, "user.json")}
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json",%{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end
end