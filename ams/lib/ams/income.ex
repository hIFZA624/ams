defmodule Ams.Income do
  @moduledoc """
  The Income context.
  """

  import Ecto.Query, warn: false
  Ams.Income.Distribution
  alias Ams.Repo
  alias Ams.Income.Incoming
  alias Ams.Income.Client

  @doc """
  Returns the list of clients.

  ## Examples

      iex> list_clients()
      [%Client{}, ...]
  """
  def list_clients do
    Repo.all(Client)
  end

  @doc """
  Gets a single client.

  Raises `Ecto.NoResultsError` if the Client does not exist.

  ## Examples

      iex> get_client!(123)
      %Client{}

      iex> get_client!(456)
      ** (Ecto.NoResultsError)

  """
  def get_client!(id), do: Repo.get!(Client, id)

  @doc """
  Creates a client.

  ## Examples

      iex> create_client(%{field: value})
      {:ok, %Client{}}

      iex> create_client(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_client(attrs \\ %{}) do
    %Client{}
    |> Client.changeset(attrs)
    |> Repo.insert()
  end
  @doc """
  Updates a client.

  ## Examples

      iex> update_client(client, %{field: new_value})
      {:ok, %Client{}}

      iex> update_client(client, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_client(%Client{} = client, attrs) do
    client
    |> Client.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a client.

  ## Examples

      iex> delete_client(client)
      {:ok, %Client{}}

      iex> delete_client(client)
      {:error, %Ecto.Changeset{}}

  """
  def delete_client(%Client{} = client) do
    Repo.delete(client)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking client changes.

  ## Examples

      iex> change_client(client)
      %Ecto.Changeset{data: %Client{}}

  """
  def change_client(%Client{} = client, attrs \\ %{}) do
    Client.changeset(client, attrs)
  end

  alias Ams.Income.Distribution

  @doc """
  Returns the list of distributions.

  ## Examples

      iex> list_distributions()
      [%Distribution{}, ...]

  """
  def list_distributions do
    Repo.all(Distribution)
  end

  @doc """
  Gets a single distribution.

  Raises `Ecto.NoResultsError` if the Distribution does not exist.

  ## Examples

      iex> get_distribution!(123)
      %Distribution{}

      iex> get_distribution!(456)
      ** (Ecto.NoResultsError)

  """
  def get_distribution!(id), do: Repo.get!(Distribution, id)

  @doc """
  Creates a distribution.

  ## Examples

      iex> create_distribution(%{field: value})
      {:ok, %Distribution{}}

      iex> create_distribution(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_distribution(attrs \\ %{}) do
    %Distribution{}
    |> Distribution.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a distribution.

  ## Examples

      iex> update_distribution(distribution, %{field: new_value})
      {:ok, %Distribution{}}

      iex> update_distribution(distribution, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_distribution(%Distribution{} = distribution, attrs) do
    distribution
    |> Distribution.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a distribution.

  ## Examples

      iex> delete_distribution(distribution)
      {:ok, %Distribution{}}

      iex> delete_distribution(distribution)
      {:error, %Ecto.Changeset{}}

  """
  def delete_distribution(%Distribution{} = distribution) do
    Repo.delete(distribution)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking distribution changes.

  ## Examples

      iex> change_distribution(distribution)
      %Ecto.Changeset{data: %Distribution{}}

  """
  def change_distribution(%Distribution{} = distribution, attrs \\ %{}) do
    Distribution.changeset(distribution, attrs)
  end

  alias Ams.Income.Incoming

  @doc """
  Returns the list of incomings.

  ## Examples

      iex> list_incomings()
      [%Incoming{}, ...]

  """
  def list_incomings do
    Repo.all(Incoming)
  end

  @doc """
  Gets a single incoming.

  Raises `Ecto.NoResultsError` if the Incoming does not exist.

  ## Examples

      iex> get_incoming!(123)
      %Incoming{}

      iex> get_incoming!(456)
      ** (Ecto.NoResultsError)

  """
  def get_incoming!(id), do: Repo.get!(Incoming, id)

  @doc """
  Creates a incoming.

  ## Examples

      iex> create_incoming(%{field: value})
      {:ok, %Incoming{}}

      iex> create_incoming(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_incoming(attrs \\ %{}) do
    %Incoming{}
    |> Incoming.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a incoming.

  ## Examples

      iex> update_incoming(incoming, %{field: new_value})
      {:ok, %Incoming{}}

      iex> update_incoming(incoming, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_incoming(%Incoming{} = incoming, attrs) do
    incoming
    |> Incoming.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a incoming.

  ## Examples

      iex> delete_incoming(incoming)
      {:ok, %Incoming{}}

      iex> delete_incoming(incoming)
      {:error, %Ecto.Changeset{}}

  """
  def delete_incoming(%Incoming{} = incoming) do
    Repo.delete(incoming)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking incoming changes.

  ## Examples

      iex> change_incoming(incoming)
      %Ecto.Changeset{data: %Incoming{}}

  """
  def change_incoming(%Incoming{} = incoming, attrs \\ %{}) do
    Incoming.changeset(incoming, attrs)
  end

  def total_income_pkr()do
    from(i in Incoming, select: sum(i.amount_pkr)) |> Repo.one
  end
  def total_income_usd()do
    from(i in Incoming, select: sum(i.amount_usd)) |> Repo.one
  end
  def total_distribution(id)do
    from(
      d in Distribution,
      inner_join: u in assoc(d, :distributed_by),
      select: %{total_usd: sum(d.amount_usd),total_pkr: sum(d.amount_pkr), from: u.name},
      group_by: u.name,
    where: d.to == ^id
    )
    |> Repo.all
  end
  def total_distribution_done(id)do
    from(
      d in Distribution,
      inner_join: u in assoc(d, :distributed_to),
      select: %{total: sum(d.amount_pkr), to: u.name},
      group_by: u.name,
    where: d.from == ^id
    )
    |> Repo.all
  end
  def total_income(id)do
    from(
      d in Incoming,
      inner_join: u in assoc(d, :client),
      select: %{total_usd: sum(d.amount_usd),total_pkr: sum(d.amount_pkr), from: u.name},
      group_by: u.name,
    where: d.recieved_by == ^id
    )|> Repo.all
  end

  #This method is for anlyze receiving
  def analyze_receiving(id,to \\ "",from \\ "") do
    IO.inspect("I am in analyze receiving block")
    IO.inspect(to)
    IO.inspect(from)
      IO.inspect("I am in data input block")
      {:ok,date_to}=Date.from_iso8601(to)

      {:ok,date_from}=Date.from_iso8601(from)
      query = from u in Incoming,
                   where: u.recieved_by== ^id and (fragment("date(?)", u.inserted_at) >= ^date_to and fragment("?::date", u.inserted_at) <= ^date_from),
                   select: u
      Repo.all(query) |> Repo.preload([:client,:reciever])

  end

  #This method is for analyze distribution
  def analyze_distribution(id,to \\ "",from \\ "") do
    IO.inspect("I am in analyze distribution block")

    {:ok,date_to}=Date.from_iso8601(to)
    {:ok,date_from}=Date.from_iso8601(from)
    query = from u in Distribution,
                 where: u.from== ^id and (fragment("date(?)", u.inserted_at) >= ^date_to and fragment("?::date", u.inserted_at) <= ^date_from),
                 select: u
  Repo.all(query) |> Repo.preload([:distributed_to,:distributed_by])
  end
end
