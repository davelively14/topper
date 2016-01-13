defmodule Topper.PageController do
  use Topper.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
