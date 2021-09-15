defmodule AmsWeb.IncomingControllerTest do
  use AmsWeb.ConnCase

  alias Ams.Income

  @create_attrs %{amount_pkr: 120.5, amount_usd: 120.5, inovice: "some inovice", medium: "some medium", recieved_on: ~D[2010-04-17], withdrawl_on: ~D[2010-04-17]}
  @update_attrs %{amount_pkr: 456.7, amount_usd: 456.7, inovice: "some updated inovice", medium: "some updated medium", recieved_on: ~D[2011-05-18], withdrawl_on: ~D[2011-05-18]}
  @invalid_attrs %{amount_pkr: nil, amount_usd: nil, inovice: nil, medium: nil, recieved_on: nil, withdrawl_on: nil}

  def fixture(:incoming) do
    {:ok, incoming} = Income.create_incoming(@create_attrs)
    incoming
  end

  describe "index" do
    test "lists all incomings", %{conn: conn} do
      conn = get(conn, Routes.incoming_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Incomings"
    end
  end

  describe "new incoming" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.incoming_path(conn, :new))
      assert html_response(conn, 200) =~ "New Incoming"
    end
  end

  describe "create incoming" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.incoming_path(conn, :create), incoming: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.incoming_path(conn, :show, id)

      conn = get(conn, Routes.incoming_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Incoming"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.incoming_path(conn, :create), incoming: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Incoming"
    end
  end

  describe "edit incoming" do
    setup [:create_incoming]

    test "renders form for editing chosen incoming", %{conn: conn, incoming: incoming} do
      conn = get(conn, Routes.incoming_path(conn, :edit, incoming))
      assert html_response(conn, 200) =~ "Edit Incoming"
    end
  end

  describe "update incoming" do
    setup [:create_incoming]

    test "redirects when data is valid", %{conn: conn, incoming: incoming} do
      conn = put(conn, Routes.incoming_path(conn, :update, incoming), incoming: @update_attrs)
      assert redirected_to(conn) == Routes.incoming_path(conn, :show, incoming)

      conn = get(conn, Routes.incoming_path(conn, :show, incoming))
      assert html_response(conn, 200) =~ "some updated inovice"
    end

    test "renders errors when data is invalid", %{conn: conn, incoming: incoming} do
      conn = put(conn, Routes.incoming_path(conn, :update, incoming), incoming: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Incoming"
    end
  end

  describe "delete incoming" do
    setup [:create_incoming]

    test "deletes chosen incoming", %{conn: conn, incoming: incoming} do
      conn = delete(conn, Routes.incoming_path(conn, :delete, incoming))
      assert redirected_to(conn) == Routes.incoming_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.incoming_path(conn, :show, incoming))
      end
    end
  end

  defp create_incoming(_) do
    incoming = fixture(:incoming)
    %{incoming: incoming}
  end
end
