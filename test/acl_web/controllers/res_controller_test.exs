defmodule AclWeb.ResControllerTest do
  use AclWeb.ConnCase

  alias Acl.Acl_context
  alias Acl.Acl_context.Res

  @create_attrs %{
    parent: "some parent",
    res: "some res"
  }
  @update_attrs %{
    parent: "some updated parent",
    res: "some updated res"
  }
  @invalid_attrs %{parent: nil, res: nil}

  def fixture(:res) do
    {:ok, res} = Acl_context.create_res(@create_attrs)
    res
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all acl_res", %{conn: conn} do
      conn = get(conn, Routes.res_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create res" do
    test "renders res when data is valid", %{conn: conn} do
      conn = post(conn, Routes.res_path(conn, :create), res: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.res_path(conn, :show, id))

      assert %{
               "id" => id,
               "parent" => "some parent",
               "res" => "some res"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.res_path(conn, :create), res: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update res" do
    setup [:create_res]

    test "renders res when data is valid", %{conn: conn, res: %Res{id: id} = res} do
      conn = put(conn, Routes.res_path(conn, :update, res), res: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.res_path(conn, :show, id))

      assert %{
               "id" => id,
               "parent" => "some updated parent",
               "res" => "some updated res"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, res: res} do
      conn = put(conn, Routes.res_path(conn, :update, res), res: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete res" do
    setup [:create_res]

    test "deletes chosen res", %{conn: conn, res: res} do
      conn = delete(conn, Routes.res_path(conn, :delete, res))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.res_path(conn, :show, res))
      end
    end
  end

  defp create_res(_) do
    res = fixture(:res)
    {:ok, res: res}
  end
end
