defmodule Ams.Accounts.UserAdmin do
  alias Ams.Accounts
  import Ecto.Query
  alias Ams.Accounts
  alias Ams.Accounts.User

  def index(_) do
    [
      id: nil,
      email: nil,
      is_admin: %{name: "Is Admin",filters: [{"is_admin",true},{"not_admin",false}]},
      email: nil,
      name: nil,
      password: nil
    ]
  end
end
