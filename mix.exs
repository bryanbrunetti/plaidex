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
    applications: [:inets, :ssl, :crypto, :httpoison]
  ]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13"},
      {:poison, "~> 3.1"},
      {:exfmt, "~> 0.4.0", only: :dev},
      {:exvcr, "~> 0.8", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Bryan Brunetti"],
      source_url: "https://github.com/deadkarma/plaidex",
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/deadkarma/plaidex",
        "Leather" => "https://leatherapp.com"
      }
    ]
  end
end
