defmodule Ams.Expense.Spending do
  use Ecto.Schema
  import Ecto.Changeset

  schema "spendings" do
    field :amount, :float
    field :notes, :string
    field :spent_on, :date
    field :title, :string
    belongs_to :paid_by, Ams.Accounts.User, [foreign_key: :spent_by]
    belongs_to :category, Ams.Expense.SubCategory
    timestamps()
  end
  @doc false
  def changeset(spending, attrs) do
    spending
    |> cast(attrs, [:title, :amount, :spent_on, :notes, :category_id, :spent_by])
    |> validate_required([:title, :amount, :spent_on, :notes])
  end
end
