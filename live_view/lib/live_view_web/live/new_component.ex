defmodule LiveViewWeb.NewComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
    <h1>Hello World from form New Component</h1>
    """
  end
end