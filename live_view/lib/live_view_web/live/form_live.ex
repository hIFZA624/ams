defmodule LiveViewWeb.FormLive do
  use LiveViewWeb, :live_view
  alias LiveView.Users
  alias LiveView.Users.User

  def mount(params, _session, socket) do
    socket = assign(socket, :abc, false)
    socket = assign(socket, :abcEdit, false)
    IO.inspect(socket)
    IO.inspect(socket.assigns)
    {:ok, socket}
  end

  def handle_event("new",_,socket) do
    IO.inspect("In handle event of new form")
    socket = assign(socket, :abc, true)
    socket = assign(socket, :abcEdit, false)
    IO.inspect(socket.assigns)
    {:noreply,socket}
    end

  def handle_event("Edit",_,socket) do
    IO.inspect("In handle event of edit form")
    socket = assign(socket, :abcEdit, true)
    socket = assign(socket, :abc, false)
    IO.inspect(socket.assigns)
    {:noreply,socket}
  end

  def handle_event("exit",_,socket) do
    IO.inspect("In handle event of edit form")
    socket = assign(socket, :abcEdit, false)
    socket = assign(socket, :abc, false)
    IO.inspect(socket.assigns)
    {:noreply,socket}
  end

end
