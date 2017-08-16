defmodule Plaidex.API.Auth do

  def auth(access_token, options \\ nil) do
    params = Plaidex.Config.credentials(access_token)
    params = case options do
      nil -> params
      options -> Map.merge(params, %{options: options})
    end

    Plaidex.API.Base.post("auth/get", params)
  end
end