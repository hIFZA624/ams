defmodule Ams.Expense.SpendingAdmin do
  alias Ams.Expense
  alias AmsWeb.Format
  import Ecto.Query

  def ordering(_schema) do
    [desc: :spent_on]
  end
  def custom_index_query(_conn, _schema, query) do
    from(r in query, preload: [:paid_by,[category: :category]])
  end

  def index(_) do
    [
      spent_on: %{
               name: "Date",
               value: fn p -> p.spent_on end },
      title: nil,
      amount: %{value: fn p -> Format.format_pkr(p.amount) end },
      notes: nil,
      paid_by: %{
        name: "Paid By",
            value: fn p -> p.paid_by.name end },
      category_id: %{
        name: "Category",
        value: fn p -> p.category.category.name<>"/"<>p.category.name end
      },
    ]
  end
  def list_actions(_conn) do
    [
      delete: %{
        name: "Delete",
        action: fn _conn, data -> delete(data) end
      },
    ]
  end

  defp delete(data) do
    Expense.delete_spendings(data)
    :ok
  end
end
