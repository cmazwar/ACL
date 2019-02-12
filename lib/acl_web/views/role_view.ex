defmodule AclWeb.RoleView do
  use AclWeb, :view
  alias AclWeb.RoleView

  def render("index.json", %{acl_roles: acl_roles}) do
    %{data: render_many(acl_roles, RoleView, "role.json")}
  end

  def render("show.json", %{role: role}) do
    %{data: render_one(role, RoleView, "role.json")}
  end

  def render("role.json", %{role: role}) do
    %{
      role: role.role,
      parent: role.parent}
  end
end
