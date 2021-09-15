defmodule AmsWeb.Format do

  def format_float(n) when is_float(n) do
    n |> :erlang.float_to_binary( [:compact, decimals: 2])
  end
  def format_pkr(n) when is_float(n) do
    "Rs. " <> (n |> :erlang.float_to_binary( [:compact, decimals: 2]))
  end
  def format_usd(n) when is_float(n) do
    "$ "<>(n |> :erlang.float_to_binary( [:compact, decimals: 2]))
  end

  def format_float(n), do: n |> to_string
  def format_pkr(n), do: n |> to_string
  def format_usd(n), do: n |> to_string

end
