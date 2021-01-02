defmodule ERAW.Client do
  @moduledoc """
  Base client to Configure Tesla
  """
  use Tesla

  # Reddit requires you to set a unique and descriptive user agent
  # do that here
  @user_agent "FLAMEO"

  def read_only_client() do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://www.api.reddit.com/"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"User-Agent", @user_agent}]}
    ]

    Tesla.client(middleware)
  end
end
