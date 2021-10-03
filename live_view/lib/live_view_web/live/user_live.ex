defmodule LiveViewWeb.UserLive do
  use LiveViewWeb, :live_view
  alias LiveView.Users
  alias LiveView.Users.User

  @impl true
  def mount(params, _session, socket) do
    {:ok, socket |>
      assign(:openModel, false)   |>
      apply_action(socket.assigns.live_action,params)
    }
  end

  def apply_action(socket,url,params) do
    case url do
    :new ->
    changeset = Users.change_user(%User{})
    socket = assign(socket, :changeset, changeset)
    socket = assign(socket, :form, "save")
    socket = assign(socket, :openModel, true)
    socket = assign(socket, :html_page, "new.html")
    socket
    :index->
      users_list = Users.list_users()
      socket = assign(socket, :user_list, users_list)
      socket = assign(socket, :html_page, "index.html")
      socket
      :Edit->
        IO.inspect("Hifza Here")
        user = Users.get_user!(params["id"])
        changeset = Users.change_user(user)
        socket = assign(socket, :changeset, changeset)
        socket = assign(socket, :form, "edit")
        socket = assign(socket, :user, user)
        socket = assign(socket, :html_page, "edit.html")
        socket
      :show->
      if(Map.has_key?(params, "id")) do
        user = Users.get_user!(params["id"])
        socket = assign(socket, :user, user)
        socket = assign(socket, :html_page, "show.html")
        socket
      end
    end
  end

  def handle_event("validate", %{"user" => params}, socket) do
    changeset =
      %User{}
      |> Users.change_user(params)
      |> Map.put(:action, :insert)
    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    IO.inspect("in save block")
    case Users.create_user(user_params) do
      {:ok, user} ->
        {:noreply,
          socket
          |> assign(:user_list, Users.list_users())
          |>   assign(:openModel, false)
          |> put_flash(:info, "User created Successfully")
         }
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
    end

  def handle_event("edit", %{"user" => user_params}, socket) do
    IO.inspect("In the update block")
    IO.inspect("Have Fun")
    user = Users.get_user!(user_params["id"])
    IO.inspect("In update block")
    IO.inspect(user_params)
    case Users.update_user(user, user_params) do
      {:ok, user} ->
      {:noreply,
      socket
      |> put_flash(:info, "User Updated Successfully")
      |>push_redirect(to: Routes.user_path(socket, :show, user))}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
          socket
          |> push_patch(to: Routes.user_path(socket, :Edit, user))}
    end
  end

 def handle_event("view_user",%{"id" => user_id},socket) do
    user = Users.get_user!(user_id)
    socket = assign(socket, :view, user)
    {:noreply, socket}
    {:noreply,
      socket
      |> push_redirect(to: Routes.user_path(socket, :show, user))}
  end

  def handle_event("edit_user",%{"id" => user_id},socket) do
    user = Users.get_user!(user_id)
    IO.inspect("In Edit block")
    IO.inspect("Hifza Here")
    changeset= Users.change_user(user)
    socket = assign(socket, :changeset, changeset)
    socket = assign(socket, :form, "edit")
    socket = assign(socket, :user, user)
    socket = assign(socket, :openModel, true)
    {:noreply, socket}
  end

  #delete a user
  def handle_event("delete_user",%{"id" => user_id},socket) do
    user = Users.get_user!(user_id)
    {:ok, _user} = Users.delete_user(user)
    users_list = Users.list_users()
    socket = assign(socket, :user_list, users_list)
    {:noreply, socket |> put_flash(:info, "User Deleted Successfully")}
  end

  def handle_event("openModel",user_id,socket) do
    socket = assign(socket, :openModel, true)
    #if connected?(socket), do: Process.send_after(self(), "display_modals", 1)
    changeset = Users.change_user(%User{})
    socket = assign(socket, :form, "save")
    socket = assign(socket, :changeset, changeset)
    {:noreply,
      socket}
  end

  def handle_event("closeModel",_params,socket) do
    socket = assign(socket, :openModel, false)
    #Process.send_after(self(), :tick, @ten_seconds)
    {:noreply, socket}
  end

  def handle_info("display_modals",socket) do
    IO.inspect("I am in handle_info")
  end

  def render(assigns) do
    LiveViewWeb.UserView.render(assigns.html_page, assigns)
  end
end
