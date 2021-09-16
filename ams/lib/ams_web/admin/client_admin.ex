defmodule Ams.Income.ClientAdmin do
  alias Ams.Expense
  import Ecto.Query
  alias Ams.Accounts
  alias Ams.Accounts.User

  def index(_) do
    [
      id: nil,
      name: nil
    ]
  end
  def custom_pages(schema, conn) do
    [
      %{
       slug: "analytic" ,
        name: "Analytic",
        view: AmsWeb.AnalyticView,
        template: "new.html",
        assigns: [users: Accounts.list_users(),  flag: false,flash: "Nothing searcehed yet",flash: "No data selected yet"],
        order: 5,
      },
    ]
  end
end
