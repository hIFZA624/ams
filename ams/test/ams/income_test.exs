defmodule Ams.IncomeTest do
  use Ams.DataCase

  alias Ams.Income

  describe "clients" do
    alias Ams.Income.Client

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def client_fixture(attrs \\ %{}) do
      {:ok, client} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Income.create_client()

      client
    end

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Income.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Income.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      assert {:ok, %Client{} = client} = Income.create_client(@valid_attrs)
      assert client.name == "some name"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Income.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      assert {:ok, %Client{} = client} = Income.update_client(client, @update_attrs)
      assert client.name == "some updated name"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Income.update_client(client, @invalid_attrs)
      assert client == Income.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Income.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Income.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Income.change_client(client)
    end
  end

  describe "distributions" do
    alias Ams.Income.Distribution

    @valid_attrs %{amount: 120.5, given_on: ~D[2010-04-17]}
    @update_attrs %{amount: 456.7, given_on: ~D[2011-05-18]}
    @invalid_attrs %{amount: nil, given_on: nil}

    def distribution_fixture(attrs \\ %{}) do
      {:ok, distribution} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Income.create_distribution()

      distribution
    end

    test "list_distributions/0 returns all distributions" do
      distribution = distribution_fixture()
      assert Income.list_distributions() == [distribution]
    end

    test "get_distribution!/1 returns the distribution with given id" do
      distribution = distribution_fixture()
      assert Income.get_distribution!(distribution.id) == distribution
    end

    test "create_distribution/1 with valid data creates a distribution" do
      assert {:ok, %Distribution{} = distribution} = Income.create_distribution(@valid_attrs)
      assert distribution.amount == 120.5
      assert distribution.given_on == ~D[2010-04-17]
    end

    test "create_distribution/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Income.create_distribution(@invalid_attrs)
    end

    test "update_distribution/2 with valid data updates the distribution" do
      distribution = distribution_fixture()
      assert {:ok, %Distribution{} = distribution} = Income.update_distribution(distribution, @update_attrs)
      assert distribution.amount == 456.7
      assert distribution.given_on == ~D[2011-05-18]
    end

    test "update_distribution/2 with invalid data returns error changeset" do
      distribution = distribution_fixture()
      assert {:error, %Ecto.Changeset{}} = Income.update_distribution(distribution, @invalid_attrs)
      assert distribution == Income.get_distribution!(distribution.id)
    end

    test "delete_distribution/1 deletes the distribution" do
      distribution = distribution_fixture()
      assert {:ok, %Distribution{}} = Income.delete_distribution(distribution)
      assert_raise Ecto.NoResultsError, fn -> Income.get_distribution!(distribution.id) end
    end

    test "change_distribution/1 returns a distribution changeset" do
      distribution = distribution_fixture()
      assert %Ecto.Changeset{} = Income.change_distribution(distribution)
    end
  end

  describe "incomings" do
    alias Ams.Income.Incoming

    @valid_attrs %{amount_pkr: 120.5, amount_usd: 120.5, inovice: "some inovice", medium: "some medium", recieved_on: ~D[2010-04-17], withdrawl_on: ~D[2010-04-17]}
    @update_attrs %{amount_pkr: 456.7, amount_usd: 456.7, inovice: "some updated inovice", medium: "some updated medium", recieved_on: ~D[2011-05-18], withdrawl_on: ~D[2011-05-18]}
    @invalid_attrs %{amount_pkr: nil, amount_usd: nil, inovice: nil, medium: nil, recieved_on: nil, withdrawl_on: nil}

    def incoming_fixture(attrs \\ %{}) do
      {:ok, incoming} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Income.create_incoming()

      incoming
    end

    test "list_incomings/0 returns all incomings" do
      incoming = incoming_fixture()
      assert Income.list_incomings() == [incoming]
    end

    test "get_incoming!/1 returns the incoming with given id" do
      incoming = incoming_fixture()
      assert Income.get_incoming!(incoming.id) == incoming
    end

    test "create_incoming/1 with valid data creates a incoming" do
      assert {:ok, %Incoming{} = incoming} = Income.create_incoming(@valid_attrs)
      assert incoming.amount_pkr == 120.5
      assert incoming.amount_usd == 120.5
      assert incoming.inovice == "some inovice"
      assert incoming.medium == "some medium"
      assert incoming.recieved_on == ~D[2010-04-17]
      assert incoming.withdrawl_on == ~D[2010-04-17]
    end

    test "create_incoming/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Income.create_incoming(@invalid_attrs)
    end

    test "update_incoming/2 with valid data updates the incoming" do
      incoming = incoming_fixture()
      assert {:ok, %Incoming{} = incoming} = Income.update_incoming(incoming, @update_attrs)
      assert incoming.amount_pkr == 456.7
      assert incoming.amount_usd == 456.7
      assert incoming.inovice == "some updated inovice"
      assert incoming.medium == "some updated medium"
      assert incoming.recieved_on == ~D[2011-05-18]
      assert incoming.withdrawl_on == ~D[2011-05-18]
    end

    test "update_incoming/2 with invalid data returns error changeset" do
      incoming = incoming_fixture()
      assert {:error, %Ecto.Changeset{}} = Income.update_incoming(incoming, @invalid_attrs)
      assert incoming == Income.get_incoming!(incoming.id)
    end

    test "delete_incoming/1 deletes the incoming" do
      incoming = incoming_fixture()
      assert {:ok, %Incoming{}} = Income.delete_incoming(incoming)
      assert_raise Ecto.NoResultsError, fn -> Income.get_incoming!(incoming.id) end
    end

    test "change_incoming/1 returns a incoming changeset" do
      incoming = incoming_fixture()
      assert %Ecto.Changeset{} = Income.change_incoming(incoming)
    end
  end
end
