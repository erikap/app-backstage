defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  match "/scores/*path" do
    Proxy.forward conn, path, "http://cache/scores/"
  end

  match "/score-parts/*path" do
    Proxy.forward conn, path, "http://cache/score-parts/"
  end

  match "/instruments/*path" do
    Proxy.forward conn, path, "http://cache/instruments/"
  end

  match "/instrument-parts/*path" do
    Proxy.forward conn, path, "http://cache/instrument-parts/"
  end

  get "/keys/*path" do
    Proxy.forward conn, path, "http://cache/keys/"
  end

  get "/clefs/*path" do
    Proxy.forward conn, path, "http://cache/clefs/"
  end

  match "/genres/*path" do
    Proxy.forward conn, path, "http://cache/genres/"
  end

  get "/score-statuses/*path" do
    Proxy.forward conn, path, "http://cache/score-statuses/"
  end

  match "/score-part-templates/*path" do
    Proxy.forward conn, path, "http://cache/score-part-templates/"
  end

  match "/files/*path" do
    Proxy.forward conn, path, "http://cache/files/"
  end

  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
