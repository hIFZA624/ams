defmodule Associations.Posts do
  import Ecto.Query, warn: false
  alias Associations.Repo
  alias Associations.Users.User
  alias Associations.Posts.Post
  alias Associations.Users

  #list all posts
  def list_posts(id) do
    query = from p in Post,
                 where: p.user_id == ^id
    Repo.all(query) |> Repo.preload(:user)
  end

  # create post
  def create_post(id,attrs \\ %{}) do
    user=Users.get_user!(id)
    body=attrs["body"]
    header=attrs["header"]
    post=%{header: header, body: body, user_id: id}
    IO.inspect(body)
    IO.inspect(header)
    IO.inspect(post)
   # post = Ecto.build_assoc(user, :posts, %{header: header, body: body, user_id: id})
    #post=Ecto.build_assoc(user, :posts, attrs)
    %Post{}
    |> Post.changeset(post)
    |> Repo.insert()
  end

  #get post
  def get_post!(user_id,post_id) do
    query= from p in Post,
    where: p.user_id== ^user_id and p.id== ^post_id
    Repo.one(query) |> Repo.preload(:user)
  end

  #delete post
  def delete_post(%Post{} = post) do
    # query=from p in Post,
    # where: p.user_id== ^user.id
    # Repo.delete_all(query)
    Repo.delete(post)
  end

  #update post
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end
end
