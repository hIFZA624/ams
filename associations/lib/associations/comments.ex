defmodule Associations.Comments do
  import Ecto.Query, warn: false
  alias Associations.Repo

  alias Associations.Users.User
  alias Associations.Posts
  alias Associations.Posts.Post
  alias Associations.Comments.Comment

  #get all comments of a post
  def list_comments(user_id,post_id)do
    query = from c in Comment,
    where:  c.post_id==^post_id and c.user_id==^user_id
    Repo.all(query) |> Repo.preload([:post, :user])
  end

  #create a comment of a post
  def create_comment(user_id,post_id,attrs \\ %{}) do
    post=Posts.get_post!(user_id,post_id)
    msg=attrs["msg"]
    IO.inspect(attrs["msg"])
    IO.inspect(post_id)
    comment=%{msg: msg, post_id: post_id ,user_id: user_id}
    %Comment{}
    |> Comment.changeset(comment)
    |> Repo.insert()
  end

  #get a specific comment of a post
  def get_comment!(user_id,post_id,comment_id) do
    query= from p in Comment,
                where: p.user_id== ^user_id and p.post_id== ^post_id and p.id== ^comment_id
    Repo.one(query) |> Repo.preload([:post, :user])
  end

  #delete comment of a post
  def delete_comment(%Comment{} = comment) do
    # query=from p in Post,
    # where: p.user_id== ^user.id
    # Repo.delete_all(query)
    Repo.delete(comment)
  end

  #update comment of a post
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end
end
