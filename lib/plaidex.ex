defmodule Plaidex do
  @moduledoc """
  Client library for Plaid
  """

  use Application

  def start(_type, _args) do
    HTTPoison.start
    Plaidex.Supervisor.start_link([])
  end

  defdelegate categories(options \\ "categories/get"), to: Plaidex.API.Base, as: :post

  defdelegate auth(access_token, params \\ nil, endpoint \\ "auth/get"), to: Plaidex.API.Base, as: :authenticated_post
  defdelegate transactions(access_token, params \\ nil, endpoint \\ "transactions/get"), to: Plaidex.API.Base, as: :authenticated_post
  defdelegate accounts(access_token, params \\ nil, endpoint \\ "accounts/get"), to: Plaidex.API.Base, as: :authenticated_post
  defdelegate identity(access_token, params \\ nil, endpoint \\ "identity/get"), to: Plaidex.API.Base, as: :authenticated_post
  defdelegate income(access_token, params \\ nil, endpoint \\ "income/get"), to: Plaidex.API.Base, as: :authenticated_post
  defdelegate balance(access_token, params \\ nil, endpoint \\ "accounts/balance/get"), to: Plaidex.API.Base, as: :authenticated_post
  defdelegate item(access_token, params \\ nil, endpoint \\ "item/get"), to: Plaidex.API.Base, as: :authenticated_post
  defdelegate webhook_update(access_token, params \\ nil, endpoint \\ "/item/webhook/update"), to: Plaidex.API.Base, as: :authenticated_post
  defdelegate item_delete(access_token, params \\ nil, endpoint \\ "/item/delete"), to: Plaidex.API.Base, as: :authenticated_post
end
