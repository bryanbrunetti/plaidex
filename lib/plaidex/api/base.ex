defmodule Plaidex.API.Base do
  @moduledoc false

  def get(endpoint, options \\ []) do
    endpoint
    |> url
    |> HTTPoison.get!(options, hackney: [pool: :default])
    |> decode_body
    |> handle_error
  end

  def post(endpoint, data \\ []) do
    endpoint
    |> url
    |> HTTPoison.post!(data |> encode, [{"Content-Type", "application/json"}], hackney: [pool: :default])
    |> decode_body
    |> handle_error
  end

  def authenticated_post(access_token, params, endpoint) do
    parameters = case params do
      nil -> Plaidex.Config.credentials(access_token)
      params -> Plaidex.Config.credentials(access_token) |> Enum.into(params)
    end

    post(endpoint, parameters)
  end

  def delete(endpoint) do
    response = endpoint
               |> url
               |> HTTPoison.delete!(%{}, hackney: [pool: :default])
    if response.status_code == 204 do
      {:ok}
    end
  end

  def patch(endpoint, data) do
    endpoint
    |> url
    |> HTTPoison.patch!(data |> encode, %{}, hackney: [pool: :default])
    |> decode_body
    |> handle_error
  end

  defp encode(data) do
    data
    |> Enum.into(%{})
    |> Poison.encode!
  end

  defp decode_body(response) do
    response.body
    |> Poison.decode!
  end

  defp url(endpoint) do
    "https://" <> environment_url() <> ".plaid.com/" <> to_string(endpoint)
  end

  defp handle_error(response) do
    case response["error_code"] do
      nil -> {:ok, response}
      _er -> {:error, response}
    end
  end

  defp environment_url, do: Plaidex.Config.environment()
end