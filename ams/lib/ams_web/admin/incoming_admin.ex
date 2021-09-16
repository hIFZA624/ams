defmodule Ams.Income.IncomingAdmin do
  alias Ams.Income
  alias Ams.Accounts
  alias AmsWeb.Format
  import Ecto.Query
  def widgets(_schema, _conn) do
    get_widgets
  end
  def get_widgets do
    [
      %{
        type: "text",
        title: "Total Income PKR",
        content: {:safe, ~s(<div>#{Format.format_pkr(Income.total_income_pkr())}</div>)},
        icon: "thumbs-up",
        order: 1,
        width: 6,
      },%{
        type: "text",
        title: "Total Income PKR",
        content: {:safe, ~s(<div>#{Format.format_usd(Income.total_income_usd())}</div>)},
        icon: "thumbs-up",
        order: 2,
        width: 6,
      }
    ]
  end
  def ordering(_schema) do
    [desc: :recieved_on]
  end
  def custom_index_query(_conn, _schema, query) do
    from(r in query, preload: [:client,:reciever])
  end
  def index(_) do
    [
      id: nil,
      amount_pkr: %{value: fn p -> Format.format_pkr(p.amount_pkr) end },
      amount_usd: %{value: fn p -> Format.format_usd(p.amount_usd) end },
      inovice: nil,
      medium: nil,
      recieved_on: nil,
      withdrawl_on: nil,
      client_id: %{name: "Client Name",value: fn p -> p.client.name end ,filters: Enum.map(Income.list_clients(),fn c->{c.name,c.id} end)},
      recieved_by: %{name: "Received By",value: fn p -> p.reciever.name end ,filters: Enum.map(Accounts.list_users(),fn u->{u.name,u.id} end)},
    ]
  end
end
