defmodule Ams.PayrollTest do
  use Ams.DataCase

  alias Ams.Payroll

  describe "departments" do
    alias Ams.Payroll.Department

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def department_fixture(attrs \\ %{}) do
      {:ok, department} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Payroll.create_department()

      department
    end

    test "list_departments/0 returns all departments" do
      department = department_fixture()
      assert Payroll.list_departments() == [department]
    end

    test "get_department!/1 returns the department with given id" do
      department = department_fixture()
      assert Payroll.get_department!(department.id) == department
    end

    test "create_department/1 with valid data creates a department" do
      assert {:ok, %Department{} = department} = Payroll.create_department(@valid_attrs)
      assert department.name == "some name"
    end

    test "create_department/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payroll.create_department(@invalid_attrs)
    end

    test "update_department/2 with valid data updates the department" do
      department = department_fixture()
      assert {:ok, %Department{} = department} = Payroll.update_department(department, @update_attrs)
      assert department.name == "some updated name"
    end

    test "update_department/2 with invalid data returns error changeset" do
      department = department_fixture()
      assert {:error, %Ecto.Changeset{}} = Payroll.update_department(department, @invalid_attrs)
      assert department == Payroll.get_department!(department.id)
    end

    test "delete_department/1 deletes the department" do
      department = department_fixture()
      assert {:ok, %Department{}} = Payroll.delete_department(department)
      assert_raise Ecto.NoResultsError, fn -> Payroll.get_department!(department.id) end
    end

    test "change_department/1 returns a department changeset" do
      department = department_fixture()
      assert %Ecto.Changeset{} = Payroll.change_department(department)
    end
  end

  describe "employees" do
    alias Ams.Payroll.Employee

    @valid_attrs %{current_designation: "some current_designation", current_salary: 120.5, email: "some email", joining_date: ~D[2010-04-17], name: "some name"}
    @update_attrs %{current_designation: "some updated current_designation", current_salary: 456.7, email: "some updated email", joining_date: ~D[2011-05-18], name: "some updated name"}
    @invalid_attrs %{current_designation: nil, current_salary: nil, email: nil, joining_date: nil, name: nil}

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Payroll.create_employee()

      employee
    end

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Payroll.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Payroll.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = Payroll.create_employee(@valid_attrs)
      assert employee.current_designation == "some current_designation"
      assert employee.current_salary == 120.5
      assert employee.email == "some email"
      assert employee.joining_date == ~D[2010-04-17]
      assert employee.name == "some name"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payroll.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{} = employee} = Payroll.update_employee(employee, @update_attrs)
      assert employee.current_designation == "some updated current_designation"
      assert employee.current_salary == 456.7
      assert employee.email == "some updated email"
      assert employee.joining_date == ~D[2011-05-18]
      assert employee.name == "some updated name"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Payroll.update_employee(employee, @invalid_attrs)
      assert employee == Payroll.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Payroll.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Payroll.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Payroll.change_employee(employee)
    end
  end

  describe "salaries" do
    alias Ams.Payroll.Salary

    @valid_attrs %{advance: 120.5, calculated_salary: 120.5, current_salary: 120.5, deductions: 120.5, full_leaves: "some full_leaves", half_leaves: 42, month: ~D[2010-04-17], notes: "some notes", over_time: 120.5, paid_on: "2010-04-17T14:00:00Z", paid_to: "some paid_to", paid_via: "some paid_via", short_leaves: 42}
    @update_attrs %{advance: 456.7, calculated_salary: 456.7, current_salary: 456.7, deductions: 456.7, full_leaves: "some updated full_leaves", half_leaves: 43, month: ~D[2011-05-18], notes: "some updated notes", over_time: 456.7, paid_on: "2011-05-18T15:01:01Z", paid_to: "some updated paid_to", paid_via: "some updated paid_via", short_leaves: 43}
    @invalid_attrs %{advance: nil, calculated_salary: nil, current_salary: nil, deductions: nil, full_leaves: nil, half_leaves: nil, month: nil, notes: nil, over_time: nil, paid_on: nil, paid_to: nil, paid_via: nil, short_leaves: nil}

    def salary_fixture(attrs \\ %{}) do
      {:ok, salary} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Payroll.create_salary()

      salary
    end

    test "list_salaries/0 returns all salaries" do
      salary = salary_fixture()
      assert Payroll.list_salaries() == [salary]
    end

    test "get_salary!/1 returns the salary with given id" do
      salary = salary_fixture()
      assert Payroll.get_salary!(salary.id) == salary
    end

    test "create_salary/1 with valid data creates a salary" do
      assert {:ok, %Salary{} = salary} = Payroll.create_salary(@valid_attrs)
      assert salary.advance == 120.5
      assert salary.calculated_salary == 120.5
      assert salary.current_salary == 120.5
      assert salary.deductions == 120.5
      assert salary.full_leaves == "some full_leaves"
      assert salary.half_leaves == 42
      assert salary.month == ~D[2010-04-17]
      assert salary.notes == "some notes"
      assert salary.over_time == 120.5
      assert salary.paid_on == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert salary.paid_to == "some paid_to"
      assert salary.paid_via == "some paid_via"
      assert salary.short_leaves == 42
    end

    test "create_salary/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payroll.create_salary(@invalid_attrs)
    end

    test "update_salary/2 with valid data updates the salary" do
      salary = salary_fixture()
      assert {:ok, %Salary{} = salary} = Payroll.update_salary(salary, @update_attrs)
      assert salary.advance == 456.7
      assert salary.calculated_salary == 456.7
      assert salary.current_salary == 456.7
      assert salary.deductions == 456.7
      assert salary.full_leaves == "some updated full_leaves"
      assert salary.half_leaves == 43
      assert salary.month == ~D[2011-05-18]
      assert salary.notes == "some updated notes"
      assert salary.over_time == 456.7
      assert salary.paid_on == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert salary.paid_to == "some updated paid_to"
      assert salary.paid_via == "some updated paid_via"
      assert salary.short_leaves == 43
    end

    test "update_salary/2 with invalid data returns error changeset" do
      salary = salary_fixture()
      assert {:error, %Ecto.Changeset{}} = Payroll.update_salary(salary, @invalid_attrs)
      assert salary == Payroll.get_salary!(salary.id)
    end

    test "delete_salary/1 deletes the salary" do
      salary = salary_fixture()
      assert {:ok, %Salary{}} = Payroll.delete_salary(salary)
      assert_raise Ecto.NoResultsError, fn -> Payroll.get_salary!(salary.id) end
    end

    test "change_salary/1 returns a salary changeset" do
      salary = salary_fixture()
      assert %Ecto.Changeset{} = Payroll.change_salary(salary)
    end
  end
end
