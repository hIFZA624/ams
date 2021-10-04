defmodule AssociationsWeb.PostController do
  use AssociationsWeb, :controller
  alias Associations.Posts
  alias Associations.Users
  alias Associations.Posts.Post

  #show all posts of a user
  def index(conn, %{"user_id" => user_id}) do
    posts = Posts.list_posts(user_id)
    IO.inspect(posts)
    render(conn, "index.json", posts: posts)
  end

  # create a post
  def create(conn, %{"user_id" => id, "post" => post_params}) do
    IO.inspect(post_params)
    IO.inspect(post_params["body"])
    IO.inspect(post_params["header"])
    case Posts.create_post(id,post_params) do
      {:ok, post} ->
        posts = Posts.list_posts(id)
        render(conn, "index.json", posts: posts)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "error.json", changeset: changeset)
    end
  end
  #show a post
  def show(conn, %{"user_id" => user_id, "id"=> id}) do
    post = Posts.get_post!(user_id,id)
    render(conn, "show.json", post: post)
  end

  #update a post
  def update(conn, %{"user_id" => user_id,"id" => id, "post" => post_params}) do
    post = Posts.get_post!(user_id,id)
    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        post = Posts.get_post!(user_id,id)
        render(conn, "show.json", post: post)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "error.json", changeset: changeset)
    end
  end

 #delete a post
  def delete(conn, %{"user_id" => user_id, "id"=> id}) do
    post = Posts.get_post!(user_id,id)
    {:ok ,post} =Posts.delete_post(post)
    posts = Posts.list_posts(user_id)
    render(conn, "index.json", posts: posts)
  end
end