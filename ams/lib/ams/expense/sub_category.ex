defmodule Ams.Expense.SubCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subcategories" do
    field :name, :string
    belongs_to :category, Ams.Expense.Category
    belongs_to :user, Ams.Accounts.User
    timestamps()
  end
  @doc false
  def changeset(sub_category, attrs) do
    sub_category
    |> cast(attrs, [:name,:category_id,:user_id])
    |> validate_required([:name])
  end
end
