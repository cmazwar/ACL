defmodule AclWeb.ResController do
  use AclWeb, :controller

  alias Acl.Acl_context
  alias Acl.Acl_context.Res

  action_fallback AclWeb.FallbackController

  def index(conn, _params) do
    acl_res = Acl_context.list_acl_res()
    render(conn, "index.json", acl_res: acl_res)
  end

  def create(res_params) do

    Acl_context.create_res(res_params)
  end

  def show(conn, %{"id" => id}) do
    res = Acl_context.get_res!(id)
    render(conn, "show.json", res: res)
  end

  def update(conn, %{"id" => id, "res" => res_params}) do
    res = Acl_context.get_res!(id)

    with {:ok, %Res{} = res} <- Acl_context.update_res(res, res_params) do
      render(conn, "show.json", res: res)
    end
  end

  def delete(conn, %{"id" => id}) do
    res = Acl_context.get_res!(id)

    with {:ok, %Res{}} <- Acl_context.delete_res(res) do
      send_resp(conn, :no_content, "")
    end
  end
end
