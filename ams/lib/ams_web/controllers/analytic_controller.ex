defmodule AmsWeb.AnalyticController do
  use AmsWeb, :controller
  alias Ams.Income
  alias Ams.Expense
  alias Ams.Income.Incoming
  alias Ams.Accounts
  alias Ams.Accounts.User

  #controller used for searching in ams Project
  def new(conn, params) do
    users = Accounts.list_users()
    flag=false

    render(conn, "new.html",users: users,flag: flag)
  end

  def create(conn, params) do
    IO.inspect("######## create app #######")
    filter_params=params["filter"]
    IO.inspect(params)
    user=Accounts.get_user!(filter_params["roles"])
    IO.inspect(user)
    users = Accounts.list_users()
    #receiving filter
    data=Income.analyze_receiving(filter_params["roles"],filter_params["date_to"],filter_params["date_from"])
    IO.inspect("Nothing received")
    IO.inspect(data)
    {list,acc_recieving}= Enum.map_reduce(data, 0, fn x, acc -> {x, x.amount_pkr + acc} end)
    {list,acc_recievings}= Enum.map_reduce(data, 0, fn x, acc -> {x, x.amount_usd + acc} end)
    IO.inspect("-----------------------")
    #distribution filter
    data_distribution=Income.analyze_distribution(filter_params["roles"],filter_params["date_to"],filter_params["date_from"])
    {list,acc_distribution}= Enum.map_reduce(data_distribution, 0, fn x, acc -> {x, x.amount_pkr + acc} end)
    {list,disc}= Enum.map_reduce(data_distribution, 0, fn x, acc -> {x, x.amount_usd + acc} end)
    IO.inspect("Data received from Receiving")
    IO.inspect(data)
    IO.inspect("Data received from distribution")
    IO.inspect(data_distribution)

    #spending filter
    data_spending=Expense.analyze_spending(filter_params["roles"],filter_params["date_to"],filter_params["date_from"])
    {list,acc_spending}= Enum.map_reduce(data_spending, 0, fn x, acc -> {x, x.amount + acc} end)
    IO.inspect("iN SEPNDING")
    IO.inspect(data_spending)
    flag=true
    users = Accounts.list_users()
    render(conn, "new.html",data: data,flag: flag,users: users,data_distribution: data_distribution,data_spending: data_spending,acc_recieving: acc_recieving,acc_recievings: acc_recievings,acc_distribution: acc_distribution,disc: disc,acc_spending: acc_spending)
  end
end
