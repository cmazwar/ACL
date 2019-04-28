defmodule AclWeb.ResView do
  @moduledoc false

  use AclWeb, :view
  alias AclWeb.ResView

  def render("index.json", %{acl_res: acl_res}) do
    %{data: render_many(acl_res, ResView, "res.json")}
  end

  def render("show.json", %{res: res}) do
    %{data: render_one(res, ResView, "res.json")}
  end

  def render("res.json", %{res: res}) do
    %{
      res: res.res,
      parent: res.parent}
  end
end
