defmodule Plaidex.Config do
  @moduledoc false

  def current_scope do
    if Process.get(:plaidex_auth, false), do: :process, else: :global
  end

  def get, do: get(current_scope())

  def credentials(access_token) do
    config = get()
    %{client_id: config[:plaid_client_id], secret: config[:plaid_secret], access_token: access_token}
  end

  def credentials do
    config = get()
    %{client_id: config[:plaid_client_id], secret: config[:plaid_secret]}
  end

  def environment_url do
    config = get()

    case config[:plaid_env] do
      nil -> default_env()
      env -> env
    end
  end

  defp get(:global) do
    case Application.get_env(:plaidex, :plaidex_auth, nil) do
      nil -> set_application_env()
      config -> config |> Enum.into(%{})
    end
  end

  defp get(:process), do: Process.get(:plaidex_auth, nil)

  defp set_application_env() do
    config = ["plaid_client_id", "plaid_public_key", "plaid_secret"]
             |> Enum.reduce(%{}, fn (v, c) -> Map.put(c, String.to_atom(v), get_system_value(v)) end)
    Application.put_env(:plaidex, :plaidex_auth, config, [])
    config
  end

  defp get_system_value(val) do
    val
    |> String.upcase()
    |> System.get_env()
  end

  def set(value), do: set(current_scope(), value)

  def set(:global, value), do: Application.put_env(:plaidex, :plaidex_auth, value, [])

  def set(:process, value) do
    Process.put(:plaidex_auth, value)
    :ok
  end

  defp default_env do
    case Mix.env do
      :prod -> "production"
      :dev -> "sandbox"
      :test -> "sandbox"
    end
  end
end
