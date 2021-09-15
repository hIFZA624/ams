defmodule Ams.Income.Distribution do
  use Ecto.Schema
  import Ecto.Changeset

  schema "distributions" do
    field :amount_pkr, :float
    field :amount_usd, :float
    field :given_on, :date
    belongs_to :distributed_to, Ams.Accounts.User, [foreign_key: :to]
    belongs_to :distributed_by, Ams.Accounts.User, [foreign_key: :from]
    timestamps()
  end
  @doc false
  def changeset(distribution, attrs) do
    distribution
    |> cast(attrs, [:amount_pkr,:amount_usd, :given_on, :to, :from])
    |> validate_required([ :given_on])
  end
end
