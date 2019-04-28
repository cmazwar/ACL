defmodule AclWeb.RoleController do
  use AclWeb, :controller

  alias Acl.Acl_context
  alias Acl.Acl_context.Role

  action_fallback AclWeb.FallbackController

  def index(conn, _params) do
    acl_roles = Acl_context.list_acl_roles()
    render(conn, "index.json", acl_roles: acl_roles)
  end

  def create( role_params) do
    Acl_context.create_role(role_params)

  end

  def show(conn, %{"id" => id}) do
    role = Acl_context.get_role!(id)
    render(conn, "show.json", role: role)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Acl_context.get_role!(id)

    with {:ok, %Role{} = role} <- Acl_context.update_role(role, role_params) do
      render(conn, "show.json", role: role)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Acl_context.get_role!(id)

    with {:ok, %Role{}} <- Acl_context.delete_role(role) do
      send_resp(conn, :no_content, "")
    end
  end
end
