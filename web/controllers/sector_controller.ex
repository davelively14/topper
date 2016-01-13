defmodule Topper.SectorController do
  use Topper.Web, :controller

  alias Topper.Sector

  plug :scrub_params, "sector" when action in [:create, :update]

  def index(conn, _params) do
    sectors = Repo.all(Sector)
    render(conn, "index.html", sectors: sectors)
  end

  def new(conn, _params) do
    changeset = Sector.changeset(%Sector{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sector" => sector_params}) do
    changeset = Sector.changeset(%Sector{}, sector_params)

    case Repo.insert(changeset) do
      {:ok, _sector} ->
        conn
        |> put_flash(:info, "Sector created successfully.")
        |> redirect(to: sector_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sector = Repo.get!(Sector, id)
    render(conn, "show.html", sector: sector)
  end

  def edit(conn, %{"id" => id}) do
    sector = Repo.get!(Sector, id)
    changeset = Sector.changeset(sector)
    render(conn, "edit.html", sector: sector, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sector" => sector_params}) do
    sector = Repo.get!(Sector, id)
    changeset = Sector.changeset(sector, sector_params)

    case Repo.update(changeset) do
      {:ok, sector} ->
        conn
        |> put_flash(:info, "Sector updated successfully.")
        |> redirect(to: sector_path(conn, :show, sector))
      {:error, changeset} ->
        render(conn, "edit.html", sector: sector, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sector = Repo.get!(Sector, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sector)

    conn
    |> put_flash(:info, "Sector deleted successfully.")
    |> redirect(to: sector_path(conn, :index))
  end
end
