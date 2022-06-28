defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    Agent.start_link(fn -> {:open, 0} end)
    |> elem(1)
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    Agent.update(account, &{:closed, &1})
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    get_balance = fn
      {:closed, _} -> {:error, :account_closed}
      {:open, balance} -> balance
    end
    Agent.get(account, get_balance)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    update_balance = fn
      {:closed, balance} -> {{:error, :account_closed}, {:closed, balance}}
      {:open, balance} -> {balance + amount, {:open, balance + amount}}
    end
    Agent.get_and_update(account, update_balance)
  end
end
