defmodule ERAW.User do
  @moduledoc """
  Retrieval for user data
  """
  alias ERAW.Helpers

  @valid_user_fields_sigil ~w(
    about comments downvoted gilded hidden saved
    overview submitted upvoted trophies
  )

  @default_options [limit: 2, sort: "new", t: "d"]
  @default_requested_return_values [:body]

  def data(client, username, attribute, requested_return_values \\ @default_requested_return_values, opts \\ @default_options) do
    # shortcut for keyword value list of tuples
    if attribute in @valid_user_fields_sigil do
      Helpers.validate_listing_parameters(opts)
      response = client |> Tesla.get("/user/#{username}/#{attribute}", query: opts)

      response_to_give = Helpers.build_response_object(response, requested_return_values)

      {:ok, response_to_give}
    else
      raise "#{attribute} is not a valid user endpoint"
    end
  end
end
