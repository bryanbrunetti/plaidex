defmodule Plaidex do
  @moduledoc """
  Documentation for Plaidex.
  """

  use Application

  def start(_type, _args) do
    HTTPoison.start
    Plaidex.Supervisor.start_link([])
  end

  defdelegate categories(options \\ "categories/get"), to: Plaidex.API.Base, as: :post
  defdelegate auth(access_token, options \\ nil), to: Plaidex.API.Auth, as: :auth
  defdelegate accounts(access_token), to: Plaidex.API.Accounts, as: :accounts
  defdelegate transactions(params), to: Plaidex.API.Transactions, as: :get
end
