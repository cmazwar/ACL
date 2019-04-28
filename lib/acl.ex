defmodule Acl do
  alias AclWeb.RuleController
  alias AclWeb.RoleController
  alias AclWeb.ResController

  @moduledoc """
  Acl keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def hasAccess(role, permission \\"read", res \\nil, action \\nil) do
    RuleController.checkRule(role, res, action, permissionTranslate(permission))
  end

  def addRule( role,res,  permission \\1, action \\nil ,condition \\1 ) do

    RuleController.addRule(role, res,  permission , action , condition )
  end
  def getRule( params) do

    RuleController.getRule(params)
  end
  def addRole( params) do

    RoleController.create(params)
  end
  def addRes( params) do

    ResController.create(params)
  end
  def allowAccess( %{__struct__: _} = rule) do

    case RuleController.denyRule(rule) do
      true -> {:ok, :allowed}
      false -> {:error, "rule not found, perhaps create new rule?"}
    end
  end

  def allowAccess(conn, params) do

    case RuleController.denyRule(params) do
      true -> {:ok, :allowed}
      false -> {:error, "rule not found, perhaps create new rule?"}
    end
  end
  def denyAccess(conn, %{__struct__: _}  = rule) do

    case RuleController.denyRule(rule) do
      true -> {:ok, :allowed}
      false -> {:error, "rule not found, perhaps create new rule?"}
    end
  end
  def denyAccess(conn, params) do

    case RuleController.denyRule(params) do
      true -> {:ok, :allowed}
      false -> {:error, "rule not found, perhaps create new rule?"}
    end
  end
  defp permissionTranslate (permission) do
    case permission do
      "POST" -> "write"
      "GET" -> "read"
      "PUT" -> "edit"
      "DELETE" -> "delete"
      "write" -> "write"
      "read" -> "read"
      "edit" -> "edit"
      "delete" -> "delete"
      _ -> nil
    end

  end

end
