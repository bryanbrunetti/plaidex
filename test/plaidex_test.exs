defmodule PlaidexTest do
  use ExUnit.Case
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")
    :ok
  end

  test "categories/get" do
    use_cassette "categories" do
      {:ok, result} = Plaidex.categories
      assert length(result["categories"]) == 602
    end
  end

  test "auth" do
    use_cassette "auth" do
      {:ok, result} = Plaidex.auth("access-sandbox-token")
      assert result["accounts"]
             |> List.first
             |> Map.get("balances")
             |> Map.get("available") == 100
    end
  end

  test "accounts" do
    use_cassette "accounts" do
      {:ok, result} = Plaidex.accounts("access-sandbox-token")
      assert result["accounts"]
             |> List.first
             |> Map.take(["name"]) == %{"name" => "Plaid Checking"}
    end
  end

  test "transactions" do
    use_cassette "transactions" do
      {:ok, result} = Plaidex.transactions("access-sandbox-token",
        start_date: "2016-01-02",
        end_date: "2016-01-02"
      )
      assert result["transactions"]
             |> List.first
             |> Map.get("amount") == -4.22
    end
  end

  test "public_token_exchange" do
    use_cassette "public_token_exchange" do
      {:ok, result} = Plaidex.public_token_exchange(
        public_token: "public-sandbox-cce1f57f-ceca-418f-bdfa-e0cbfee7c3e6"
      )

      assert result["access_token"]
      assert result["item_id"]
    end
  end

  test "create_stripe_bank_account_token" do
    use_cassette "create_stripe_bank_token" do
      {:ok, result} = Plaidex.create_stripe_bank_token("access-sandbox-token",
        account_id: "sandbox-account-id"
      )

      assert result["stripe_bank_account_token"]
    end
  end
end
