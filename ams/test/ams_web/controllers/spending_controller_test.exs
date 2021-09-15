defmodule AmsWeb.SpendingControllerTest do
  use AmsWeb.ConnCase

  alias Ams.Expense

  @create_attrs %{amount: 120.5, notes: "some notes", spent_on: ~D[2010-04-17], title: "some title"}
  @update_attrs %{amount: 456.7, notes: "some updated notes", spent_on: ~D[2011-05-18], title: "some updated title"}
  @invalid_attrs %{amount: nil, notes: nil, spent_on: nil, title: nil}

  def fixture(:spending) do
    {:ok, spending} = Expense.create_spending(@create_attrs)
    spending
  end

  describe "index" do
    test "lists all spendings", %{conn: conn} do
      conn = get(conn, Routes.spending_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Spendings"
    end
  end

  describe "new spending" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.spending_path(conn, :new))
      assert html_response(conn, 200) =~ "New Spending"
    end
  end

  describe "create spending" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.spending_path(conn, :create), spending: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.spending_path(conn, :show, id)

      conn = get(conn, Routes.spending_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Spending"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.spending_path(conn, :create), spending: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Spending"
    end
  end

  describe "edit spending" do
    setup [:create_spending]

    test "renders form for editing chosen spending", %{conn: conn, spending: spending} do
      conn = get(conn, Routes.spending_path(conn, :edit, spending))
      assert html_response(conn, 200) =~ "Edit Spending"
    end
  end

  describe "update spending" do
    setup [:create_spending]

    test "redirects when data is valid", %{conn: conn, spending: spending} do
      conn = put(conn, Routes.spending_path(conn, :update, spending), spending: @update_attrs)
      assert redirected_to(conn) == Routes.spending_path(conn, :show, spending)

      conn = get(conn, Routes.spending_path(conn, :show, spending))
      assert html_response(conn, 200) =~ "some updated notes"
    end

    test "renders errors when data is invalid", %{conn: conn, spending: spending} do
      conn = put(conn, Routes.spending_path(conn, :update, spending), spending: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Spending"
    end
  end

  describe "delete spending" do
    setup [:create_spending]

    test "deletes chosen spending", %{conn: conn, spending: spending} do
      conn = delete(conn, Routes.spending_path(conn, :delete, spending))
      assert redirected_to(conn) == Routes.spending_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.spending_path(conn, :show, spending))
      end
    end
  end

  defp create_spending(_) do
    spending = fixture(:spending)
    %{spending: spending}
  end
end
