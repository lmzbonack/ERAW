defmodule ERAW.Subreddit do
  @moduledoc """
  Retrieval for subreddit posts
  """
  alias ERAW.Helpers

  @valid_subreddit_endpoint_options ~w(
    hot new rising top controversial
  )

  @default_options [limit: 2, t: "week"]
  @default_requested_return_values [:body]

  def data(client, subreddit_name, subreddit_endpoint, requested_return_values \\ @default_requested_return_values, opts \\ @default_options) do
    if subreddit_endpoint not in @valid_subreddit_endpoint_options do
      {:error, "#{subreddit_endpoint} is not a valid subreddit endpoint"}
    else
      Helpers.validate_listing_parameters(opts)
      response = client |> Tesla.get("/r/#{subreddit_name}/#{subreddit_endpoint}", query: opts)
      response_to_give = Helpers.build_response_object(response, requested_return_values)
      {:ok, response_to_give}
    end
  end

  def random_post(client, subreddit_name) do
    headers = client
    |> Tesla.get("/r/#{subreddit_name}/random")
    |> Helpers.retrieve_response_headers()
    |> List.pop_at(5)

    {location_pair, _} = headers
    {"location", value} = location_pair
    {:ok, value}
  end
end
