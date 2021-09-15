defmodule Ams.Income.Incoming do
  use Ecto.Schema
  import Ecto.Changeset

  schema "incomings" do
    field :amount_pkr, :float
    field :amount_usd, :float
    field :inovice, :string
    field :medium, :string
    field :recieved_on, :date
    field :withdrawl_on, :date
    belongs_to :client, Ams.Income.Client
    belongs_to :reciever, Ams.Accounts.User, [foreign_key: :recieved_by]
    timestamps()
  end
  @doc false
  def changeset(incoming, attrs) do
    incoming
    |> cast(attrs, [:amount_usd, :amount_pkr, :inovice, :medium, :recieved_on, :withdrawl_on, :client_id, :recieved_by])
    |> validate_required([:amount_usd, :amount_pkr, :inovice, :medium, :recieved_on, :withdrawl_on])
  end
end
