defmodule Ams.Income.DistributionAdmin do
  alias Ams.Income
  alias Ams.Accounts
  alias AmsWeb.Format
  import Ecto.Query
  alias AmsWeb.Format

  def widgets(_schema, _conn) do
      get_widgets
  end
  def get_widgets do
    Accounts.list_users |> Enum.map(&user_widget/1)
  end
  def user_widget(user) do
    %{
      type: "text",
      title: "#{user.name} Accounts",
      content: {:safe, user_status(user.id)},
      icon: "user",
      order: user.id+2,
      width: 4,
    }
  end
  def user_status(id)do
    income = (Ams.Income.total_distribution(id)++Ams.Income.total_income(id))
    expense = Ams.Expense.total_spending(id)
    spent = Ams.Expense.total_spent(id) ++ Ams.Income.total_distribution_done(id)
     acc ="<h3>Received</h3>"
     acc = Enum.reduce(income,acc, fn i,a -> a<>form_income_string(i,id)
     end)
     acc = acc <> "<h4>Spent on me</h4>"
    acc =  Enum.reduce(expense,acc, fn i,a -> a<>form_expense_string(i)
     end)
    acc = acc <> "<h4>Spent by me</h4>"
    acc =  Enum.reduce(spent,acc, fn i,a -> a<>form_spent_string(i)
     end)
    acc = acc <> "<h3>Total</h3>"
    acc =  acc <> get_total_string(income,expense,spent,id)||""
  end
  def get_total_string(income,expense,spent,id)do
    income = income |> Enum.reduce(0, fn c,a -> a+c.total_pkr end)
    expense = expense |> Enum.reduce(0, fn c,a -> a+c.total end)
    spent = spent |> Enum.reduce(0, fn c,a -> a+c.total end)
    total_income = if id == 4 do
      income
      else
      income+expense
    end
    total_expense = if id == 4 do
      expense
      else
      spent
    end
    balance = total_income-total_expense
    s= "<table>"
    s =s<> "<tr><td>Income</td><td>#{total_income|>Format.format_pkr}</td></tr>"
    s =s<> "<tr><td>Expense</td><td>#{total_expense|>Format.format_pkr}</td></tr>"
    s =s<> "<tr><td>Net total</td><td>#{balance|>Format.format_pkr}</td></tr>"
    s = s<> case id do
          1 -> "<tr><td>Brought Forward</td><td>#{(-1024495.68)|>Format.format_pkr}</td></tr>"
              <> "<tr><td>Balance</td><td>#{(balance-get_share-1024495.68)|>Format.format_pkr}</td></tr>"
          2 -> "<tr><td>Balance</td><td>#{(balance-get_share)|>Format.format_pkr}</td></tr>"
          4 -> "<tr><td>Share</td><td>#{(balance/2)|>Format.format_pkr}</td></tr>"
          _ -> ""
        end
    s=s<> "</table>"
  end
  def get_share()do
    income = (Ams.Income.total_distribution(4)++Ams.Income.total_income(4))
    expense = Ams.Expense.total_spending(4)
    spent = Ams.Expense.total_spent(4) ++ Ams.Income.total_distribution_done(4)
    income = income |> Enum.reduce(0, fn c,a -> a+c.total_pkr end)
    expense = expense |> Enum.reduce(0, fn c,a -> a+c.total end)
    (income - expense)/2
  end
  def form_income_string(income,id)do
    s= "<table>"
    s = s<> (id != 4 &&income.total_usd&&"<tr><td>From #{income.from}</td><td> #{income.total_usd|>Format.format_usd}</td></tr>"||"")
    <> "<tr><td>From #{income.from} </td><td> #{income.total_pkr|>Format.format_pkr}</td></tr>"
    s=s<> "</table>"
  end
  def form_expense_string(expense)do
    s= "<table>"
    s =s<> "<tr><td>From #{expense.from} </td><td>  #{expense.total|>Format.format_pkr}</td></tr>"
    s=s<> "</table>"
  end
  def form_spent_string(spent)do
    s= "<table>"
    s =s<> "<tr><td>To #{spent.to} </td><td>  #{spent.total|>Format.format_pkr}</td></tr>"
    s=s<> "</table>"
  end
  def ordering(_schema) do
    [desc: :given_on]
  end
  def custom_index_query(_conn, _schema, query) do
    from(r in query, preload: [:distributed_to,:distributed_by])
  end
  def index(_) do
    [
      amount_pkr: %{value: fn p -> Format.format_pkr(p.amount_pkr) end },
      amount_usd: %{value: fn p -> Format.format_usd(p.amount_usd) end },
      given_on: %{name: "Date"},
      to: %{name: "Given To",value: fn p -> p.distributed_to.name end ,filters: Enum.map(Accounts.list_users(),fn d->{d.name,d.id} end)},
    from: %{name: "Given By",value: fn p -> p.distributed_by.name end ,filters: Enum.map(Accounts.list_users(),fn d->{d.name,d.id} end)},
    ]
  end
end
