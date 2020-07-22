defmodule AclWeb.RuleController do
  @moduledoc false

  use AclWeb, :controller

  alias Acl.Acl_context
  alias Acl.Acl_context.Rule


  action_fallback AclWeb.FallbackController

  def index(conn, _params) do
    acl_rules = Acl_context.list_acl_rules()
    render(conn, "index.json", acl_rules: acl_rules)
  end

  def create(conn, %{"rule" => rule_params}) do
    with {:ok, %Rule{} = rule} <- Acl_context.create_rule(rule_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.rule_path(conn, :show, rule))
      |> render("show.json", rule: rule)
    end
  end

  def show(conn, %{"role" => role, "res" => res, "permission" => permission, "action" => action}) do
    rule = Acl_context.get_rule!([role, res, permission, action])
    render(conn, "show.json", rule: rule)
  end

  def update(conn, %{"id" => id, "rule" => rule_params}) do
    rule = Acl_context.get_rule!(id)

    with {:ok, %Rule{} = rule} <- Acl_context.update_rule(rule, rule_params) do
      render(conn, "show.json", rule: rule)
    end
  end

  def delete(conn, %{"id" => id}) do
    rule = Acl_context.get_rule!(id)

    with {:ok, %Rule{}} <- Acl_context.delete_rule(rule) do
      send_resp(conn, :no_content, "")
    end
  end

  def getRule(params)do

    rule = Acl_context.get_rule_by(params)
    case rule do
      nil -> {:error, "rule_doesnt_exist"}
      _ -> rule
    end
  end


  def checkRule(role, res, action, permission)do

    case Acl_context.get_rule_by(role) do
      {:error, error} -> {:error, error}
      records -> iterateRules(res, action, permission, Map.from_struct(records).rules)
      _ -> {:error, :permission_denied}
    end


  end
  def iterateRules(res, action, permission, [rule | rules]) do
    cond do
      rule.res.res == res and rule.action == action and rule.permission >= permission(permission) ->
        formAclResponse(rule)
      rule.res.res == res and rule.permission >= permission(permission) ->
        formAclResponse(rule)
      rule.res.res == nil and rule.permission >= permission(permission) ->
        formAclResponse(rule)
      true ->
        iterateRules(res, action, permission, rules)
    end

  end
  def iterateRules(res, action, permission, []), do: {:error, :permission_denied}
  def formAclResponse(rule) do
    if rule.where_cond == nil or rule.where_field == nil or rule.where_value == nil do
      {
        :ok,
        %{
          "condition" => condition(rule.condition),
          "permission" => permission(rule.permission),
          "role" => rule.role,
          "res" => rule.res.res,
          "$where" => %{}
        }
      }
    else
      whereclause = %{
        rule.where_field => %{
          rule.where_cond => rule.where_value
        }
      }
      {
        :ok,
        %{
          "condition" => condition(rule.condition),
          "permission" => permission(rule.permission),
          "role" => rule.role,
          "res" => rule.res.res,
          "$where" => whereclause
        }
      }
    end
  end


  def permission (param) do
    case param do
      0 -> 0
      1 -> 1
      2 -> 2
      3 -> 3
      4 -> 4
      "read" -> 1
      "write" -> 2
      "delete" -> 3
      "edit" -> 4
      "none" -> 0
      _ -> nil
    end

  end
  def condition (param) do
    case param do
      0 -> "none"
      1 -> "self"
      2 -> "related"
      3 -> "all"
    end
  end


  def addRule(role, res_, permission \\ 1, action \\ nil, condition \\ 1)do

    case Acl_context.get_res(res_) do
      res ->

        rule_= Acl_context.get_rule_by(
          %{"role" => role, "res" => res.id,  "action" => action}
        );
        case rule_
          do
          {:error, :rule_not_found} ->
            Acl_context.create_rule(
              %{"role" => role, "res" => res, "permission" => permission(permission), "action" => action, "condition" => condition}
            )
          {:error, _} ->
            {:error, :error_occured}
          [rule|_] ->
            Acl_context.update_rule(
              rule,
              %{
                "role" => role,
                "res" => res,
                "permission" => permission(permission),
                "action" => action,
                "condition" => condition
              }
            )
        end
      nil -> {:error, :res_unknown}

    end
  end

  def allowRule(
        %{"role" => role, "res" => res, "permission" => permission, "action" => action, "condition" => condition}
      )do
    rule = Acl_context.get_rule_by(%{"role" => role, "res" => res, "permission" => permission, "action" => action});
    if rule! = nil
      do
      Acl_context.update_rule(rule, %{"allowed" => true, "condition" => condition})
      true
    else
      false
    end
  end
  def allowRule(%Rule{} = rule)do

    Acl_context.update_rule(rule, %{"allowed" => true})
  end

  def denyRule(
        %{"role" => role, "res" => res, "permission" => permission, "action" => action, "condition" => condition}
      )do
    rule = Acl_context.get_rule_by(%{"role" => role, "res" => res, "permission" => permission, "action" => action});
    if rule! = nil
      do
      Acl_context.update_rule(rule, %{"allowed" => false, "condition" => condition})
      true
    else
      false
    end
  end

  def denyRule(%Rule{} = rule)do
    Acl_context.update_rule(rule, %{"allowed" => false})
  end


end

