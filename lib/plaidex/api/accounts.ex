defmodule Plaidex.API.Accounts do
  def accounts(access_token) do
    "accounts/get"
    |> Plaidex.API.Base.post(Plaidex.Config.credentials(access_token))
  end
end