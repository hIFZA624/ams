defmodule AssociationsWeb.CommentController do
  use AssociationsWeb, :controller
  alias Associations.Posts
  alias Associations.Users
  alias Associations.Comments
  alias Associations.Posts.Post


  #show all comments of a post
  def index(conn, %{"user_id" => user_id,"post_id" => post_id}) do
    comments = Comments.list_comments(user_id,post_id)
    IO.inspect(comments)
    render(conn, "index.json", comments: comments)
  end
  # create a comment
  def create(conn, %{"user_id" => user_id,"post_id" => post_id, "comment" => comment_params}) do
    case Comments.create_comment(user_id,post_id,comment_params) do
      {:ok, comment} ->
        comments = Comments.list_comments(user_id,post_id)
        render(conn, "index.json", comments: comments)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "error.json", changeset: changeset)
    end
  end

  #update a post
  def update(conn, %{"user_id" => user_id, "post_id"=> post_id,"id" => comment_id, "comment" => comment_params}) do
    comment = Comments.get_comment!(user_id,post_id,comment_id)
    case Comments.update_comment(comment, comment_params) do
      {:ok, comment} ->
        comment = Comments.get_comment!(user_id,post_id,comment_id)
        render(conn, "show.json", comment: comment)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "error.json", changeset: changeset)
    end
  end

  #show a post
  def show(conn, %{"user_id" => user_id, "post_id"=> post_id,"id" => comment_id}) do
    comment = Comments.get_comment!(user_id,post_id,comment_id)
    render(conn, "show.json", comment: comment)
  end

  #delete a comment
  def delete(conn, %{"user_id" => user_id, "post_id"=> post_id,"id" => comment_id}) do
    comment = Comments.get_comment!(user_id,post_id,comment_id)
    {:ok ,comment} =Comments.delete_comment(comment)

    comments = Comments.list_comments(user_id,post_id)
    render(conn, "index.json", comments: comments)
  end
end