defmodule Ams.ExpenseTest do
  use Ams.DataCase

  alias Ams.Expense

  describe "categories" do
    alias Ams.Expense.Category

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Expense.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Expense.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Expense.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Expense.create_category(@valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expense.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Expense.update_category(category, @update_attrs)
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Expense.update_category(category, @invalid_attrs)
      assert category == Expense.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Expense.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Expense.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Expense.change_category(category)
    end
  end

  describe "subcategories" do
    alias Ams.Expense.SubCategory

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def sub_category_fixture(attrs \\ %{}) do
      {:ok, sub_category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Expense.create_sub_category()

      sub_category
    end

    test "list_subcategories/0 returns all subcategories" do
      sub_category = sub_category_fixture()
      assert Expense.list_subcategories() == [sub_category]
    end

    test "get_sub_category!/1 returns the sub_category with given id" do
      sub_category = sub_category_fixture()
      assert Expense.get_sub_category!(sub_category.id) == sub_category
    end

    test "create_sub_category/1 with valid data creates a sub_category" do
      assert {:ok, %SubCategory{} = sub_category} = Expense.create_sub_category(@valid_attrs)
      assert sub_category.name == "some name"
    end

    test "create_sub_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expense.create_sub_category(@invalid_attrs)
    end

    test "update_sub_category/2 with valid data updates the sub_category" do
      sub_category = sub_category_fixture()
      assert {:ok, %SubCategory{} = sub_category} = Expense.update_sub_category(sub_category, @update_attrs)
      assert sub_category.name == "some updated name"
    end

    test "update_sub_category/2 with invalid data returns error changeset" do
      sub_category = sub_category_fixture()
      assert {:error, %Ecto.Changeset{}} = Expense.update_sub_category(sub_category, @invalid_attrs)
      assert sub_category == Expense.get_sub_category!(sub_category.id)
    end

    test "delete_sub_category/1 deletes the sub_category" do
      sub_category = sub_category_fixture()
      assert {:ok, %SubCategory{}} = Expense.delete_sub_category(sub_category)
      assert_raise Ecto.NoResultsError, fn -> Expense.get_sub_category!(sub_category.id) end
    end

    test "change_sub_category/1 returns a sub_category changeset" do
      sub_category = sub_category_fixture()
      assert %Ecto.Changeset{} = Expense.change_sub_category(sub_category)
    end
  end

  describe "spendings" do
    alias Ams.Expense.Spending

    @valid_attrs %{amount: 120.5, notes: "some notes", spent_on: ~D[2010-04-17], title: "some title"}
    @update_attrs %{amount: 456.7, notes: "some updated notes", spent_on: ~D[2011-05-18], title: "some updated title"}
    @invalid_attrs %{amount: nil, notes: nil, spent_on: nil, title: nil}

    def spending_fixture(attrs \\ %{}) do
      {:ok, spending} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Expense.create_spending()

      spending
    end

    test "list_spendings/0 returns all spendings" do
      spending = spending_fixture()
      assert Expense.list_spendings() == [spending]
    end

    test "get_spending!/1 returns the spending with given id" do
      spending = spending_fixture()
      assert Expense.get_spending!(spending.id) == spending
    end

    test "create_spending/1 with valid data creates a spending" do
      assert {:ok, %Spending{} = spending} = Expense.create_spending(@valid_attrs)
      assert spending.amount == 120.5
      assert spending.notes == "some notes"
      assert spending.spent_on == ~D[2010-04-17]
      assert spending.title == "some title"
    end

    test "create_spending/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expense.create_spending(@invalid_attrs)
    end

    test "update_spending/2 with valid data updates the spending" do
      spending = spending_fixture()
      assert {:ok, %Spending{} = spending} = Expense.update_spending(spending, @update_attrs)
      assert spending.amount == 456.7
      assert spending.notes == "some updated notes"
      assert spending.spent_on == ~D[2011-05-18]
      assert spending.title == "some updated title"
    end

    test "update_spending/2 with invalid data returns error changeset" do
      spending = spending_fixture()
      assert {:error, %Ecto.Changeset{}} = Expense.update_spending(spending, @invalid_attrs)
      assert spending == Expense.get_spending!(spending.id)
    end

    test "delete_spending/1 deletes the spending" do
      spending = spending_fixture()
      assert {:ok, %Spending{}} = Expense.delete_spending(spending)
      assert_raise Ecto.NoResultsError, fn -> Expense.get_spending!(spending.id) end
    end

    test "change_spending/1 returns a spending changeset" do
      spending = spending_fixture()
      assert %Ecto.Changeset{} = Expense.change_spending(spending)
    end
  end
end
