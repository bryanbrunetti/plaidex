defmodule Plaidex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :plaidex,
      version: "0.1.0",
      elixir: "~> 1.5",
      package: package(),
      description: "Plaid client library for Elixir",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  [
    mod: {Plaidex, []},
    applications: [:inets, :ssl, :crypto]
  ]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13"},
      {:exvcr, "~> 0.8", only: :test},
    ]
  end

  defp package do
    [
      maintainers: ["Bryan Brunetti"],
      links: %{
        "GitHub" => "https://github.com/deadkarma/plaidex"
      }
    ]
  end
end
