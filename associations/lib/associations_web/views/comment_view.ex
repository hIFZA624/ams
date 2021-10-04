defmodule AssociationsWeb.CommentView do
  use AssociationsWeb, :view

  def render("index.json", %{comments: comments}) do
    IO.inspect(comments)
    %{data: render_many(comments, AssociationsWeb.CommentView, "comment.json")}
  end

  def render("comment.json",%{comment: comment}) do
    %{msg: comment.msg, post_id: comment.post_id,user_id: comment.user_id, comment_id: comment.id,post: render_one(comment.post,AssociationsWeb.PostView,"post.json"), user: render_one(comment.user,AssociationsWeb.UserView,"user.json")}
  end

  def render("show.json",%{comment: comment}) do
    %{data: render_one(comment, AssociationsWeb.CommentView, "comment.json")}
  end
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json",%{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end
end
