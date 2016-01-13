defmodule Topper.StreetController do
  use Topper.Web, :controller

  alias Topper.Street

  plug :scrub_params, "street" when action in [:create, :update]

  def index(conn, _params) do
    streets = Repo.all(Street)
    render(conn, "index.html", streets: streets)
  end

  def new(conn, _params) do
    changeset = Street.changeset(%Street{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"street" => street_params}) do
    changeset = Street.changeset(%Street{}, street_params)

    case Repo.insert(changeset) do
      {:ok, _street} ->
        conn
        |> put_flash(:info, "Street created successfully.")
        |> redirect(to: street_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    street = Repo.get!(Street, id)
    render(conn, "show.html", street: street)
  end

  def edit(conn, %{"id" => id}) do
    street = Repo.get!(Street, id)
    changeset = Street.changeset(street)
    render(conn, "edit.html", street: street, changeset: changeset)
  end

  def update(conn, %{"id" => id, "street" => street_params}) do
    street = Repo.get!(Street, id)
    changeset = Street.changeset(street, street_params)

    case Repo.update(changeset) do
      {:ok, street} ->
        conn
        |> put_flash(:info, "Street updated successfully.")
        |> redirect(to: street_path(conn, :show, street))
      {:error, changeset} ->
        render(conn, "edit.html", street: street, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    street = Repo.get!(Street, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(street)

    conn
    |> put_flash(:info, "Street deleted successfully.")
    |> redirect(to: street_path(conn, :index))
  end
end
