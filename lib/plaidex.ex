defmodule Plaidex do
  @moduledoc """
  Documentation for Plaidex.
  """

    use Application

    def start(_type, _args) do
      HTTPoison.start
      Plaidex.Supervisor.start_link([])
    end
end
