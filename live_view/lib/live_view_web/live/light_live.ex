defmodule LiveViewWeb.LightLive do
  use LiveViewWeb, :live_view
  alias LiveView.Users
  alias LiveView.Users.User
  #mount function used to make re render html pages
  def mount(_params, _session, socket) do
    IO.inspect("In Mount function")
    changeset = Users.change_user(%User{})
    socket = assign(socket, :form, "save")
    socket = assign(socket, :changeset, changeset)
    socket = assign(socket, :brightness, 10)
    IO.inspect(socket.assigns)
    {:ok ,socket}
  end
  def handle_event("on",_, socket) do
    if(socket.assigns.brightness !=100) do
    IO.inspect("Button On")
    socket = assign(socket, :brightness, 100)
    {:noreply, socket |> clear_flash()}
  else
      {:noreply,
        socket
        |> put_flash(:info, "Light is already on")}
  end
  end
  @impl true
  def handle_event("off", _, socket) do
    if(socket.assigns.brightness !=0) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket |> clear_flash()}
    else
      {:noreply,
        socket
        |> put_flash(:info, "Light is already off")}
    end
  end
  def handle_event("down", _, socket) do
    if(socket.assigns.brightness-10 >=0) do
      brightness = socket.assigns.brightness - 10
      socket = assign(socket, :brightness, brightness)
      {:noreply, socket |> clear_flash()}
    else
      {:noreply,
        socket
        |> put_flash(:info, "Light is already off")}
    end
  end
  def handle_event("up", _, socket) do
    if(socket.assigns.brightness+10 <=100) do
     brightness = socket.assigns.brightness + 10
     socket = assign(socket, :brightness, brightness)
     {:noreply, socket |> clear_flash()}
     else
     {:noreply,
     socket
     |> put_flash(:info, "Light is already on")}
    end
  end
  end
