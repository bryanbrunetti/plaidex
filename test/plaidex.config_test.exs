defmodule Plaidex.Config.Test do
  use ExUnit.Case
  doctest Plaidex

  setup do
    System.put_env("PLAID_CLIENT_ID", "")
    System.put_env("PLAID_PUBLIC_KEY", "")
    System.put_env("PLAID_SECRET", "")
    Application.put_env(:plaidex, :plaidex_auth, nil, [])
  end

  test "global env config" do
    System.put_env("PLAID_CLIENT_ID", "8675309")
    System.put_env("PLAID_PUBLIC_KEY", "ABCDEFG")
    System.put_env("PLAID_SECRET", "SHHHHhHhHHH")
    result = Plaidex.Config.get

    assert result[:plaid_client_id] == System.get_env("PLAID_CLIENT_ID")
    assert result[:plaid_public_key] == System.get_env("PLAID_PUBLIC_KEY")
    assert result[:plaid_secret] == System.get_env("PLAID_SECRET")
  end

  test "process config" do
    Plaidex.Config.set(:process, "plaid_client_id": "5551212")
    result = Plaidex.Config.get
    assert result[:plaid_client_id] == "5551212"
    assert result[:plaid_secret] == nil
  end

  test "application config" do
    Application.put_env(:plaidex, :plaidex_auth,
      plaid_client_id: "5551212",
      plaid_secret: "SHHHHhHhHHH"
    )
    result = Plaidex.Config.get
    assert result[:plaid_client_id] == "5551212"
    assert result[:plaid_secret] == "SHHHHhHhHHH"
  end

  test "environment url default" do
    assert Plaidex.Config.environment_url == "sandbox"
  end

  test "environment url" do
    Application.put_env(:plaidex, :plaidex_auth, plaid_env: "development")
    assert Plaidex.Config.environment_url == "development"
  end

  test "setting a non env global config" do
    Plaidex.Config.set(
      :global,
      %{"plaid_client_id": "987654321", "plaid_public_key": "publicly", "plaid_secret": "foooshh"}
    )
    result = Plaidex.Config.get
    assert result[:plaid_client_id] == "987654321"
  end

end
