# Plaidex

Some would call this a client library for [Plaid](https://plaid.com), but
it's simply a little bit of code on top of [HTTPoison](https://github.com/edgurgel/httpoison) 
made for use in [Leather](https://leatherapp.com)

## Installation

Add `plaidex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:plaidex, "~> 0.1.0"}
  ]
end
```

# Configuration

Configuration can be done two ways, with environment variables or with [Process](https://hexdocs.pm/elixir/Process.html).

- Set the following environment variables to the appropriate values:
  - PLAID_CLIENT_ID
  - PLAID_PUBLIC_KEY
  - PLAID_SECRET
  
or from within a process:

- ```elixir
  Plaidex.Config.set(plaid_client_id: "abc123", plaid_secret: "shh")
```
