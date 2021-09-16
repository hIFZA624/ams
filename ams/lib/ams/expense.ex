defmodule Ams.Expense do
  @moduledoc """
  The Expense context.
  """

  import Ecto.Query, warn: false
  alias Ams.Repo
alias Ams.Expense.Spending
  alias Ams.Expense.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end



  alias Ams.Expense.SubCategory

  @doc """
  Returns the list of subcategories.

  ## Examples

      iex> list_subcategories()
      [%SubCategory{}, ...]

  """
  def list_subcategories do
    Repo.all(SubCategory) |> Repo.preload([:category])

  end

  @doc """
  Gets a single sub_category.

  Raises `Ecto.NoResultsError` if the Sub category does not exist.

  ## Examples

      iex> get_sub_category!(123)
      %SubCategory{}

      iex> get_sub_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sub_category!(id), do: Repo.get!(SubCategory, id)

  @doc """
  Creates a sub_category.

  ## Examples

      iex> create_sub_category(%{field: value})
      {:ok, %SubCategory{}}

      iex> create_sub_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sub_category(attrs \\ %{}) do
    %SubCategory{}
    |> SubCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sub_category.

  ## Examples

      iex> update_sub_category(sub_category, %{field: new_value})
      {:ok, %SubCategory{}}

      iex> update_sub_category(sub_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sub_category(%SubCategory{} = sub_category, attrs) do
    sub_category
    |> SubCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sub_category.

  ## Examples

      iex> delete_sub_category(sub_category)
      {:ok, %SubCategory{}}

      iex> delete_sub_category(sub_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sub_category(%SubCategory{} = sub_category) do
    Repo.delete(sub_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sub_category changes.

  ## Examples

      iex> change_sub_category(sub_category)
      %Ecto.Changeset{data: %SubCategory{}}

  """
  def change_sub_category(%SubCategory{} = sub_category, attrs \\ %{}) do
    SubCategory.changeset(sub_category, attrs)
  end

  alias Ams.Expense.Spending

  @doc """
  Returns the list of spendings.

  ## Examples

      iex> list_spendings()
      [%Spending{}, ...]

  """
  def list_spendings do
    Repo.all(Spending)
  end

  @doc """
  Gets a single spending.

  Raises `Ecto.NoResultsError` if the Spending does not exist.

  ## Examples

      iex> get_spending!(123)
      %Spending{}

      iex> get_spending!(456)
      ** (Ecto.NoResultsError)

  """
  def get_spending!(id), do: Repo.get!(Spending, id)

  @doc """
  Creates a spending.

  ## Examples

      iex> create_spending(%{field: value})
      {:ok, %Spending{}}

      iex> create_spending(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_spending(attrs \\ %{}) do
    %Spending{}
    |> Spending.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a spending.

  ## Examples

      iex> update_spending(spending, %{field: new_value})
      {:ok, %Spending{}}

      iex> update_spending(spending, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_spending(%Spending{} = spending, attrs) do
    spending
    |> Spending.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a spending.

  ## Examples

      iex> delete_spending(spending)
      {:ok, %Spending{}}

      iex> delete_spending(spending)
      {:error, %Ecto.Changeset{}}

  """
  def delete_spending(%Spending{} = spending) do
    Repo.delete(spending)
  end
  def delete_spendings( spendings) do
    Enum.map(spendings, fn s -> delete_spending(s) end)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking spending changes.

  ## Examples

      iex> change_spending(spending)
      %Ecto.Changeset{data: %Spending{}}

  """
  def change_spending(%Spending{} = spending, attrs \\ %{}) do
    Spending.changeset(spending, attrs)
  end

  def total_spending(id)do
    from(
      s in Spending,
      left_join: u in assoc(s, :paid_by),
      inner_join: c in assoc(s, :category),
      select: %{total: sum(s.amount), from: u.name},
      group_by: u.name,
      where: c.user_id == ^id
    )|> Repo.all
  end

  def total_spent(id)do
    from(
      s in Spending,
      left_join: u in assoc(s, :paid_by),
      inner_join: d in assoc(s, :category),
      inner_join: c in assoc(d,  :user),
      select: %{total: sum(s.amount), to: c.name},
      group_by: c.name,
      where: u.id == ^id
    )|> Repo.all
  end

  def analyze_spending(id,tos \\ "",froms \\ "") do

    query = from u in Spending,
                 where: u.spent_by== ^id,
                        where: ^filter_status(tos,froms),
                 select: u
    Repo.all(query) |> Repo.preload([:paid_by,:category])



  end
  def filter_status(tos,froms) do
    date=""
    to= case Date.from_iso8601(tos) do
      {:ok, dates} ->
        dates
      {:error, :invalid_format} ->
        date
    end
    from= case Date.from_iso8601(froms) do
      {:ok, dates} ->
        dates
      {:error, :invalid_format} ->
        date
    end
    cond do
      to != "" and from != "" ->
        dynamic([u], (fragment("date(?)", u.inserted_at) >= ^to and fragment("?::date", u.inserted_at) <= ^from))
      to == "" and from == "" ->
        true
      to != "" and from == "" ->
        dynamic([u], fragment("date(?)", u.inserted_at) >= ^to)
      to == "" and from != "" ->
        dynamic([u], fragment("?::date", u.inserted_at) <= ^from)
    end
  end

end
