defmodule AclWeb.RuleView do
  @moduledoc false

  use AclWeb, :view
  alias AclWeb.RuleView

  def render("index.json", %{acl_rules: acl_rules}) do
    %{data: render_many(acl_rules, RuleView, "rule.json")}
  end

  def render("show.json", %{rule: rule}) do
    %{data: render_one(rule, RuleView, "rule.json")}
  end

  def render("rule.json", %{rule: rule}) do
    %{
      action: rule.action,
      permission: rule.permission,
      allowed: rule.allowed,
      role: rule.role,
      res: rule.res,
    }
  end
end
