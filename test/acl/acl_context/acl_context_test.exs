defmodule Acl.Acl_contextTest do
  use Acl.DataCase

  alias Acl.Acl_context

  describe "acl_roles" do
    alias Acl.Acl_context.Role

    @valid_attrs %{parent: "some parent", role: "some role"}
    @update_attrs %{parent: "some updated parent", role: "some updated role"}
    @invalid_attrs %{parent: nil, role: nil}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Acl_context.create_role()

      role
    end

    test "list_acl_roles/0 returns all acl_roles" do
      role = role_fixture()
      assert Acl_context.list_acl_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Acl_context.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Acl_context.create_role(@valid_attrs)
      assert role.parent == "some parent"
      assert role.role == "some role"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Acl_context.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, %Role{} = role} = Acl_context.update_role(role, @update_attrs)
      assert role.parent == "some updated parent"
      assert role.role == "some updated role"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Acl_context.update_role(role, @invalid_attrs)
      assert role == Acl_context.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Acl_context.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Acl_context.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Acl_context.change_role(role)
    end
  end

  describe "acl_res" do
    alias Acl.Acl_context.Res

    @valid_attrs %{parent: "some parent", res: "some res"}
    @update_attrs %{parent: "some updated parent", res: "some updated res"}
    @invalid_attrs %{parent: nil, res: nil}

    def res_fixture(attrs \\ %{}) do
      {:ok, res} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Acl_context.create_res()

      res
    end

    test "list_acl_res/0 returns all acl_res" do
      res = res_fixture()
      assert Acl_context.list_acl_res() == [res]
    end

    test "get_res!/1 returns the res with given id" do
      res = res_fixture()
      assert Acl_context.get_res!(res.id) == res
    end

    test "create_res/1 with valid data creates a res" do
      assert {:ok, %Res{} = res} = Acl_context.create_res(@valid_attrs)
      assert res.parent == "some parent"
      assert res.res == "some res"
    end

    test "create_res/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Acl_context.create_res(@invalid_attrs)
    end

    test "update_res/2 with valid data updates the res" do
      res = res_fixture()
      assert {:ok, %Res{} = res} = Acl_context.update_res(res, @update_attrs)
      assert res.parent == "some updated parent"
      assert res.res == "some updated res"
    end

    test "update_res/2 with invalid data returns error changeset" do
      res = res_fixture()
      assert {:error, %Ecto.Changeset{}} = Acl_context.update_res(res, @invalid_attrs)
      assert res == Acl_context.get_res!(res.id)
    end

    test "delete_res/1 deletes the res" do
      res = res_fixture()
      assert {:ok, %Res{}} = Acl_context.delete_res(res)
      assert_raise Ecto.NoResultsError, fn -> Acl_context.get_res!(res.id) end
    end

    test "change_res/1 returns a res changeset" do
      res = res_fixture()
      assert %Ecto.Changeset{} = Acl_context.change_res(res)
    end
  end

  describe "acl_rules" do
    alias Acl.Acl_context.Rule

    @valid_attrs %{action: "some action", allowed: true, permission: "some permission"}
    @update_attrs %{action: "some updated action", allowed: false, permission: "some updated permission"}
    @invalid_attrs %{action: nil, allowed: nil, permission: nil}

    def rule_fixture(attrs \\ %{}) do
      {:ok, rule} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Acl_context.create_rule()

      rule
    end

    test "list_acl_rules/0 returns all acl_rules" do
      rule = rule_fixture()
      assert Acl_context.list_acl_rules() == [rule]
    end

    test "get_rule!/1 returns the rule with given id" do
      rule = rule_fixture()
      assert Acl_context.get_rule!(rule.id) == rule
    end

    test "create_rule/1 with valid data creates a rule" do
      assert {:ok, %Rule{} = rule} = Acl_context.create_rule(@valid_attrs)
      assert rule.action == "some action"
      assert rule.allowed == true
      assert rule.permission == "some permission"
    end

    test "create_rule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Acl_context.create_rule(@invalid_attrs)
    end

    test "update_rule/2 with valid data updates the rule" do
      rule = rule_fixture()
      assert {:ok, %Rule{} = rule} = Acl_context.update_rule(rule, @update_attrs)
      assert rule.action == "some updated action"
      assert rule.allowed == false
      assert rule.permission == "some updated permission"
    end

    test "update_rule/2 with invalid data returns error changeset" do
      rule = rule_fixture()
      assert {:error, %Ecto.Changeset{}} = Acl_context.update_rule(rule, @invalid_attrs)
      assert rule == Acl_context.get_rule!(rule.id)
    end

    test "delete_rule/1 deletes the rule" do
      rule = rule_fixture()
      assert {:ok, %Rule{}} = Acl_context.delete_rule(rule)
      assert_raise Ecto.NoResultsError, fn -> Acl_context.get_rule!(rule.id) end
    end

    test "change_rule/1 returns a rule changeset" do
      rule = rule_fixture()
      assert %Ecto.Changeset{} = Acl_context.change_rule(rule)
    end
  end
end
