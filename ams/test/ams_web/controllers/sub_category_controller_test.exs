defmodule AmsWeb.SubCategoryControllerTest do
  use AmsWeb.ConnCase

  alias Ams.Expense

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:sub_category) do
    {:ok, sub_category} = Expense.create_sub_category(@create_attrs)
    sub_category
  end

  describe "index" do
    test "lists all subcategories", %{conn: conn} do
      conn = get(conn, Routes.sub_category_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Subcategories"
    end
  end

  describe "new sub_category" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.sub_category_path(conn, :new))
      assert html_response(conn, 200) =~ "New Sub category"
    end
  end

  describe "create sub_category" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.sub_category_path(conn, :create), sub_category: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.sub_category_path(conn, :show, id)

      conn = get(conn, Routes.sub_category_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Sub category"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.sub_category_path(conn, :create), sub_category: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Sub category"
    end
  end

  describe "edit sub_category" do
    setup [:create_sub_category]

    test "renders form for editing chosen sub_category", %{conn: conn, sub_category: sub_category} do
      conn = get(conn, Routes.sub_category_path(conn, :edit, sub_category))
      assert html_response(conn, 200) =~ "Edit Sub category"
    end
  end

  describe "update sub_category" do
    setup [:create_sub_category]

    test "redirects when data is valid", %{conn: conn, sub_category: sub_category} do
      conn = put(conn, Routes.sub_category_path(conn, :update, sub_category), sub_category: @update_attrs)
      assert redirected_to(conn) == Routes.sub_category_path(conn, :show, sub_category)

      conn = get(conn, Routes.sub_category_path(conn, :show, sub_category))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, sub_category: sub_category} do
      conn = put(conn, Routes.sub_category_path(conn, :update, sub_category), sub_category: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Sub category"
    end
  end

  describe "delete sub_category" do
    setup [:create_sub_category]

    test "deletes chosen sub_category", %{conn: conn, sub_category: sub_category} do
      conn = delete(conn, Routes.sub_category_path(conn, :delete, sub_category))
      assert redirected_to(conn) == Routes.sub_category_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.sub_category_path(conn, :show, sub_category))
      end
    end
  end

  defp create_sub_category(_) do
    sub_category = fixture(:sub_category)
    %{sub_category: sub_category}
  end
end
