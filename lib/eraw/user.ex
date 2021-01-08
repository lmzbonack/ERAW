defmodule ERAW.User do
  @moduledoc """
  Retrieval for user posts and other data related to users
  """
  alias ERAW.Helpers

  @valid_user_fields ~w(
    about comments downvoted gilded hidden saved
    overview submitted upvoted trophies
  )

  @valid_logged_in_user_fields ~w(
    downvoted gilded hidden saved upvoted
  )

  # Sort refers to hot, new top, and controversial
  @default_options [limit: 2, sort: "new", t: "day"]
  @default_requested_return_values [:body]

  def data(client, username, attribute, requested_return_values \\ @default_requested_return_values, opts \\ @default_options) do
    if attribute not in @valid_user_fields do
      {:error, "#{attribute} is not a valid user endpoint"}
    else
      Helpers.validate_listing_parameters(opts)
      response = client |> Tesla.get("/user/#{username}/#{attribute}", query: opts)
      IO.inspect(response)
      response_to_give = Helpers.build_response_object(response, requested_return_values)
      {:ok, response_to_give}
    end
  end

  def search(client, query, requested_return_values \\ @default_requested_return_values, opts \\ @default_options) do
    Helpers.validate_listing_parameters(opts)
    new_opts = opts ++ [q: query]
    response = client |> Tesla.get("/users/search", query: new_opts)
    response_to_give = Helpers.build_response_object(response, requested_return_values)
    {:ok, response_to_give}
  end
end

# client = ERAW.Client.read_only_client
# {:ok, yeet} = ERAW.User.data(client, "da_vasily_da")
