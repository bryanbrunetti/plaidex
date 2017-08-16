defmodule Plaidex.API.Transactions do

  def get(params) do
  params = Enum.into(params, Plaidex.Config.credentials(params[:access_token]))
  "transactions/get"
  |> Plaidex.API.Base.post(params)
  end
end