defmodule AmsWeb.DistributionControllerTest do
  use AmsWeb.ConnCase

  alias Ams.Income

  @create_attrs %{amount: 120.5, given_on: ~D[2010-04-17]}
  @update_attrs %{amount: 456.7, given_on: ~D[2011-05-18]}
  @invalid_attrs %{amount: nil, given_on: nil}

  def fixture(:distribution) do
    {:ok, distribution} = Income.create_distribution(@create_attrs)
    distribution
  end

  describe "index" do
    test "lists all distributions", %{conn: conn} do
      conn = get(conn, Routes.distribution_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Distributions"
    end
  end

  describe "new distribution" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.distribution_path(conn, :new))
      assert html_response(conn, 200) =~ "New Distribution"
    end
  end

  describe "create distribution" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.distribution_path(conn, :create), distribution: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.distribution_path(conn, :show, id)

      conn = get(conn, Routes.distribution_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Distribution"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.distribution_path(conn, :create), distribution: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Distribution"
    end
  end

  describe "edit distribution" do
    setup [:create_distribution]

    test "renders form for editing chosen distribution", %{conn: conn, distribution: distribution} do
      conn = get(conn, Routes.distribution_path(conn, :edit, distribution))
      assert html_response(conn, 200) =~ "Edit Distribution"
    end
  end

  describe "update distribution" do
    setup [:create_distribution]

    test "redirects when data is valid", %{conn: conn, distribution: distribution} do
      conn = put(conn, Routes.distribution_path(conn, :update, distribution), distribution: @update_attrs)
      assert redirected_to(conn) == Routes.distribution_path(conn, :show, distribution)

      conn = get(conn, Routes.distribution_path(conn, :show, distribution))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, distribution: distribution} do
      conn = put(conn, Routes.distribution_path(conn, :update, distribution), distribution: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Distribution"
    end
  end

  describe "delete distribution" do
    setup [:create_distribution]

    test "deletes chosen distribution", %{conn: conn, distribution: distribution} do
      conn = delete(conn, Routes.distribution_path(conn, :delete, distribution))
      assert redirected_to(conn) == Routes.distribution_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.distribution_path(conn, :show, distribution))
      end
    end
  end

  defp create_distribution(_) do
    distribution = fixture(:distribution)
    %{distribution: distribution}
  end
end
