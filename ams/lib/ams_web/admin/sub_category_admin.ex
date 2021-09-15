defmodule Ams.Expense.SubCategoryAdmin do
  alias Ams.Expense
  import Ecto.Query

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
      },
      user_id: %{
      name: "For User",
            value: fn p -> p.user&&p.user.name||p.user end,
                           },
    ]
  end
end
