defmodule AssociationsWeb.AvatarView do
  use AssociationsWeb, :view


  def render("avatar.json",%{avatar: avatar}) do
    %{nick_name: avatar.nick_name, pic_url: avatar.pic_url, user_id: avatar.user_id, id: avatar.id,user: render_one(avatar.user,AssociationsWeb.UserView,"user.json")}
  end

  def render("show.json",%{avatar: avatar}) do
    %{data: render_one(avatar, AssociationsWeb.AvatarView, "avatar.json")}
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json",%{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end
end
