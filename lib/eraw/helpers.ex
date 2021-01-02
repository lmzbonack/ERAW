defmodule ERAW.Helpers do
  @moduledoc """
  Helpers for input validation and other things
  """

  # Do further validation here to make sure inputs make sense
  def validate_listing_parameters(listings) do
    Enum.each listings, fn listing ->
      case listing do
        {:limit, value} ->
          IO.puts("Limit value #{value}")
        {:sort, value} ->
          IO.puts("Sort value #{value}")
        {:t, value} ->
          IO.puts("t value #{value}")
        {:after, value} ->
          IO.puts("after value #{value}")
        {:before, value} ->
          IO.puts("before value #{value}")
        {:count, value} ->
          IO.puts("count value #{value}")
        {:show, value} ->
          IO.puts("show value #{value}")
        {_, value} ->
          raise "invalid listing param specified with value of #{value}"
      end
    end
  end

  def retrieve_response_body(response) do
    {:ok, result} = response
    result.body["data"]
  end

  def retrieve_response_headers(response) do
    {:ok, result} = response
    result.headers
  end

  def retrieve_response_status(response) do
    {:ok, result} = response
    result.status
  end

  def build_response_object(reddit_response, requested_values) do
    Enum.reduce requested_values, %{}, fn value, response_object ->
      case value do
        :status -> Map.put(response_object, :status, reddit_response |> retrieve_response_status)
        :body -> Map.put(response_object, :body, reddit_response |> retrieve_response_body)
        :headers -> Map.put(response_object, :headers, reddit_response |> retrieve_response_headers)
        _ -> raise "Invalid requested return value specified valid values are :status, :body, and :headers"
      end
    end
  end

end
