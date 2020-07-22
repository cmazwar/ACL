defmodule AclWeb.RuleControllerTest do
  use AclWeb.ConnCase

  alias Acl.Acl_context
  alias Acl.Acl_context.Rule

  @create_attrs %{
    action: "some action",
    allowed: true,
    permission: "some permission"
  }
  @update_attrs %{
    action: "some updated action",
    allowed: false,
    permission: "some updated permission"
  }
  @invalid_attrs %{action: nil, allowed: nil, permission: nil}

  def fixture(:rule) do
    {:ok, rule} = Acl_context.create_rule(@create_attrs)
    rule
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all acl_rules", %{conn: conn} do
      conn = get(conn, Routes.rule_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create rule" do
    test "renders rule when data is valid", %{conn: conn} do
      conn = post(conn, Routes.rule_path(conn, :create), rule: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.rule_path(conn, :show, id))

      assert %{
               "id" => id,
               "action" => "some action",
               "allowed" => true,
               "permission" => "some permission"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.rule_path(conn, :create), rule: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update rule" do
    setup [:create_rule]

    test "renders rule when data is valid", %{conn: conn, rule: %Rule{id: id} = rule} do
      conn = put(conn, Routes.rule_path(conn, :update, rule), rule: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.rule_path(conn, :show, id))

      assert %{
               "id" => id,
               "action" => "some updated action",
               "allowed" => false,
               "permission" => "some updated permission"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, rule: rule} do
      conn = put(conn, Routes.rule_path(conn, :update, rule), rule: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete rule" do
    setup [:create_rule]

    test "deletes chosen rule", %{conn: conn, rule: rule} do
      conn = delete(conn, Routes.rule_path(conn, :delete, rule))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.rule_path(conn, :show, rule))
      end
    end
  end

  defp create_rule(_) do
    rule = fixture(:rule)
    {:ok, rule: rule}
  end
end
