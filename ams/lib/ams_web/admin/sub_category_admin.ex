defmodule Ams.Expense.SubCategoryAdmin do
  alias Ams.Expense
  import Ecto.Query
  alias Ams.Accounts

  def custom_index_query(_conn, _schema, query) do
    from(r in query, preload: [:category,:user])
  end

  def index(_) do
    [
      id: nil,
      name: nil,
      category_id: %{
        name: "Category",
        value: fn p -> p.category.name end,
        filters: Enum.map(Expense.list_categories(),fn c->{c.name,c.id} end)
      },
      user_id: %{
      name: "For User",
            value: fn p -> p.user&&p.user.name||p.user end,
        filters: Enum.map(Accounts.list_users(),fn c->{c.name,c.id} end)
                           },
    ]
  end
end
