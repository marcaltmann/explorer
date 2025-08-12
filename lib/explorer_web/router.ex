defmodule ExplorerWeb.Router do
  use ExplorerWeb, :router

  import ExplorerWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ExplorerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_scope_for_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExplorerWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/accessibility", PageController, :accessibility
    get "/contact", PageController, :contact
    get "/legal-notice", PageController, :legal_notice
    get "/privacy", PageController, :privacy
    get "/terms", PageController, :terms

    get "/collections", CollectionController, :index
    get "/collections/new", CollectionController, :new
    post "/collections/create", CollectionController, :create
    get "/collections/:id", CollectionController, :show
    get "/collections/:id/edit", CollectionController, :edit
    put "/collections/:id/update", CollectionController, :update
    post "/collections/:id/delete", CollectionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExplorerWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:explorer, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ExplorerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", ExplorerWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
  end

  scope "/", ExplorerWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm-email/:token", UserSettingsController, :confirm_email
  end

  scope "/", ExplorerWeb do
    pipe_through [:browser]

    get "/users/log-in", UserSessionController, :new
    get "/users/log-in/:token", UserSessionController, :confirm
    post "/users/log-in", UserSessionController, :create
    delete "/users/log-out", UserSessionController, :delete
  end


  ## Admin/Editor routes

  scope "/", ExplorerWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/editor", EditorController, :home
  end
end
