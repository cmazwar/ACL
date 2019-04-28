# Acl

ACL or access control list is a list of permissions attached to a specific object for certain users.
This ACL is designed to be used in a phoneix project and handles all your permissions managment.
 It requires following depedencies
 
 '''
      {:ecto_sql, "\~> 3.0"}
      {:jason, "~> 1.0"}
      {:plug_cowboy, "~> 1.0.0"}
      {:ex_doc, ">= 0.0.0", only: :dev}
      {:phoenix, "~> 1.3.0"}
      {:phoenix_pubsub, "~> 1.0"}
      {:phoenix_ecto, "~> 3.2"}
      {:postgrex, ">= 0.0.0"}
      {:phoenix_html, "~> 2.10"}
      {:phoenix_live_reload, "~> 1.0", only: :dev}
      {:gettext, "~> 0.11"}
      {:cowboy, "~> 1.0"}
'''







To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
