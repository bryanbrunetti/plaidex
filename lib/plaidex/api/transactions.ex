defmodule Plaidex.API.Transactions do
  def get(access_token: access_token, start_date: start_date, end_date: end_date) do
    transactions(%{access_token: access_token, start_date: start_date, end_date: end_date})
  end

  def get(access_token: access_token, start_date: start_date, end_date: end_date, options: options) do
    transactions(%{access_token: access_token, start_date: start_date, end_date: end_date, options: options})
  end

  defp transactions(params) do
  params = Map.merge(params, Plaidex.Config.credentials(params[:access_token]))
  "transactions/get"
  |> Plaidex.API.Base.post(params)
  end
end