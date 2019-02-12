defmodule AclWeb.RuleController do
  use AclWeb, :controller

  alias Acl.Acl_context
  alias Acl.Acl_context.Rule


  action_fallback AclWeb.FallbackController

  def index(conn, _params) do
#    IO.inspect(_params)
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

  def show(conn, %{"role" => role, "res" => res, "permission" => permission, "action" => action }) do
    rule = Acl_context.get_rule!(role, res, permission, action)
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
  def checkRule( %{"role" => role, "res" => res, "permission" => permission, "action" => action }= params)do

    rule = Acl_context.get_rule_by(params)
    case rule do
      nil -> getRule( %{"role" => role, "res" => res, "permission" => nil, "action" => action })
      _ -> rule.allowed
    end
  end
  def checkRule( %{"role" => role, "res" => res, "permission" => nil, "action" => action }= params)do

    rule = Acl_context.get_rule_by( params)
    case rule do
      nil -> getRule( %{"role" => role, "res" => res, "permission" => nil, "action" => nil})
      _ -> rule.allowed
    end
  end
  def checkRule( %{"role" => role, "res" => res, "permission" => nil, "action" => nil}= params)do

    rule = Acl_context.get_rule_by(params)
    case rule do
      nil -> false
      _ -> rule.allowed
    end
  end


  def addRule( %{"role" => role, "res" => res, "permission" => permission, "action" => action, "allowed" => allowed })do
    rule=Acl_context.get_rule_by( %{"role" => role, "res" => res, "permission" => permission, "action" => action });
  IO.inspect(rule);
    case rule
      do
    nil ->  Acl_context.create_rule(%{"role" => role, "res" => res, "permission" => permission, "action" => action, "allowed" => allowed })

     _ -> Acl_context.update_rule(rule, %{"role" => role, "res" => res, "permission" => permission, "action" => action, "allowed" => allowed })
    end
  end

  def allowRule( %{"role" => role, "res" => res, "permission" => permission, "action" => action })do
    rule=Acl_context.get_rule_by( %{"role" => role, "res" => res, "permission" => permission, "action" => action });
    if rule!= nil
      do
      Acl_context.update_rule(rule,%{"allowed" => true })
      true
      else
      false
    end
  end
  def allowRule( %Rule{}= rule)do

      Acl_context.update_rule(rule,%{"allowed" => true })
  end

  def denyRule( %{"role" => role, "res" => res, "permission" => permission, "action" => action })do
    rule=Acl_context.get_rule_by( %{"role" => role, "res" => res, "permission" => permission, "action" => action });
    if rule!= nil
      do
      Acl_context.update_rule(rule,%{ "allowed" => false })
      true
      else
      false
    end
  end

  def denyRule( %Rule{}= rule)do
    Acl_context.update_rule(rule,%{"allowed" => false })
  end


end

