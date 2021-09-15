defmodule Ams.Kaffy.Extension do
  def stylesheets(_conn) do
  if String.contains?(_conn.request_path,"dashboard") do
    [
      {:safe, ~s(<style>.stretch-card table{table-layout: fixed ;width: 100%}</style>)}
    ]
    else
    [
      {:safe, ~s(<link rel="stylesheet" href="/css/app.css" />)}
    ]
    end

  end

end
