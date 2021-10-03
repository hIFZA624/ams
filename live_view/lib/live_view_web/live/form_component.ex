defmodule LiveViewWeb.FormComponent do
  use LiveViewWeb, :live_component
  alias LiveView.Users
  alias LiveView.Users.User

  def update(assigns, socket) do
    IO.inspect(assigns)
    result=Map.get(assigns, :flag)
    IO.inspect(result)
    if(result=="false") do
      changeset = Users.change_user(%User{})
      socket = socket
               |> assign(:form, "save")
               |> assign(:changeset, changeset)
               |> assign(:abc, true)
      {:ok, socket |> assign(assigns)}
      else
      user = Users.get_user!(36)
      changeset = Users.change_user(user)
      socket = socket
               |> assign(:form, "edit")
               |> assign(:changeset, changeset)
               |> assign(:abc, true)
      {:ok, socket |> assign(assigns)}
    end
  end

  def handle_event("save",%{"user"=>user_params},socket) do
    IO.inspect("In save ")
    {:ok,user}=Users.create_user(user_params)
    {:noreply,socket}
  end

  def handle_event("edit", %{"user" => user_params}, socket) do
    IO.inspect("In the update block")
    IO.inspect("Have Fun")
    user = Users.get_user!(user_params["id"])
    IO.inspect("In update block")
    IO.inspect(user_params)
    Users.update_user(user, user_params)
    {:noreply,socket}
  end
end
