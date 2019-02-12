defmodule AclWeb.AclController do

  use AclWeb, :controller

  alias AclWeb.RuleController
  alias AclWeb.ResController
  alias AclWeb.RoleController


  def hasAccess?(conn, params) do

    RuleController.checkRule(params)
  end
  def addRule(conn, params) do

    RuleController.addRule(params)
  end
  def getRule(conn, params) do

    RuleController.getRule(params)
  end
  def addAclRole(conn, params) do

    IO.inspect(params)
    RuleController.addRule(params)
  end
  def addAclRes(conn, params) do

    RuleController.addRule(params)
  end
  def allowAccess(conn, %{__struct__: _} = rule) do

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



end
