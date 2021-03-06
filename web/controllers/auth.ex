defmodule Topper.Auth do
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2]
  import Phoenix.Controller
  alias Topper.Route.Helpers

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(Topper.User, user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def login_email_pass(conn, email, password, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Topper.User, email: email)

    cond do
      user && checkpw(password, user.pass_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        {:error, :not_found, conn}
    end
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access this page")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end
end