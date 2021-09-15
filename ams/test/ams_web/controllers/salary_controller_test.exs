defmodule AmsWeb.SalaryControllerTest do
  use AmsWeb.ConnCase

  alias Ams.Payroll

  @create_attrs %{advance: 120.5, calculated_salary: 120.5, current_salary: 120.5, deductions: 120.5, full_leaves: "some full_leaves", half_leaves: 42, month: ~D[2010-04-17], notes: "some notes", over_time: 120.5, paid_on: "2010-04-17T14:00:00Z", paid_to: "some paid_to", paid_via: "some paid_via", short_leaves: 42}
  @update_attrs %{advance: 456.7, calculated_salary: 456.7, current_salary: 456.7, deductions: 456.7, full_leaves: "some updated full_leaves", half_leaves: 43, month: ~D[2011-05-18], notes: "some updated notes", over_time: 456.7, paid_on: "2011-05-18T15:01:01Z", paid_to: "some updated paid_to", paid_via: "some updated paid_via", short_leaves: 43}
  @invalid_attrs %{advance: nil, calculated_salary: nil, current_salary: nil, deductions: nil, full_leaves: nil, half_leaves: nil, month: nil, notes: nil, over_time: nil, paid_on: nil, paid_to: nil, paid_via: nil, short_leaves: nil}

  def fixture(:salary) do
    {:ok, salary} = Payroll.create_salary(@create_attrs)
    salary
  end

  describe "index" do
    test "lists all salaries", %{conn: conn} do
      conn = get(conn, Routes.salary_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Salaries"
    end
  end

  describe "new salary" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.salary_path(conn, :new))
      assert html_response(conn, 200) =~ "New Salary"
    end
  end

  describe "create salary" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.salary_path(conn, :create), salary: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.salary_path(conn, :show, id)

      conn = get(conn, Routes.salary_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Salary"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.salary_path(conn, :create), salary: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Salary"
    end
  end

  describe "edit salary" do
    setup [:create_salary]

    test "renders form for editing chosen salary", %{conn: conn, salary: salary} do
      conn = get(conn, Routes.salary_path(conn, :edit, salary))
      assert html_response(conn, 200) =~ "Edit Salary"
    end
  end

  describe "update salary" do
    setup [:create_salary]

    test "redirects when data is valid", %{conn: conn, salary: salary} do
      conn = put(conn, Routes.salary_path(conn, :update, salary), salary: @update_attrs)
      assert redirected_to(conn) == Routes.salary_path(conn, :show, salary)

      conn = get(conn, Routes.salary_path(conn, :show, salary))
      assert html_response(conn, 200) =~ "some updated full_leaves"
    end

    test "renders errors when data is invalid", %{conn: conn, salary: salary} do
      conn = put(conn, Routes.salary_path(conn, :update, salary), salary: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Salary"
    end
  end

  describe "delete salary" do
    setup [:create_salary]

    test "deletes chosen salary", %{conn: conn, salary: salary} do
      conn = delete(conn, Routes.salary_path(conn, :delete, salary))
      assert redirected_to(conn) == Routes.salary_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.salary_path(conn, :show, salary))
      end
    end
  end

  defp create_salary(_) do
    salary = fixture(:salary)
    %{salary: salary}
  end
end
