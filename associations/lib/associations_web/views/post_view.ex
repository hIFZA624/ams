defmodule AssociationsWeb.PostView do
  use AssociationsWeb, :view

  def render("index.json", %{posts: posts}) do
    IO.inspect(posts)
    %{data: render_many(posts, AssociationsWeb.PostView, "post.json")}
  end

  def render("post.json",%{post: post}) do
    if(Ecto.assoc_loaded?(post.user)) do
      %{header: post.header ,body: post.body, id: post.id, user: render_one(post.user,AssociationsWeb.UserView,"user.json")}
      else
      %{header: post.header ,body: post.body, id: post.id}
      end
  end

  def render("show.json",%{post: post}) do
    %{data: render_one(post, AssociationsWeb.PostView, "post.json")}
  end
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json",%{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end
end