defmodule Dispatcher do
  use Matcher

  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    html: [ "text/html", "application/xhtml+html" ],
    any: [ "*/*" ]
  ]

  @html %{ accept: %{ html: true } }
  @json %{ accept: %{ json: true } }
  @any %{ accept: %{ any: true } }

  options "*path", _ do
    conn
    |> Plug.Conn.put_resp_header( "access-control-allow-headers", "content-type,accept" )
    |> Plug.Conn.put_resp_header( "access-control-allow-methods", "*" )
    |> send_resp( 200, "{ \"message\": \"ok\" }" )
  end

  match "/scores/*path", @json do
    forward conn, path, "http://cache/scores"
  end

  match "/score-parts/*path", @json do
    forward conn, path, "http://cache/score-parts"
  end

  match "/instruments/*path", @json do
    forward conn, path, "http://cache/instruments/"
  end

  match "/instrument-parts/*path", @json do
    forward conn, path, "http://cache/instrument-parts/"
  end

  get "/keys/*path", @json do
    forward conn, path, "http://cache/keys/"
  end

  get "/clefs/*path", @json do
    forward conn, path, "http://cache/clefs/"
  end

  match "/genres/*path", @json do
    forward conn, path, "http://cache/genres/"
  end

  get "/score-statuses/*path", @json do
    forward conn, path, "http://cache/score-statuses/"
  end

  match "/score-part-templates/*path", @json do
    forward conn, path, "http://cache/score-part-templates/"
  end

  match "/files/*path", @json do
    forward conn, path, "http://cache/files/"
  end

  match "_", %{ last_call: true, accept: %{ json: true } } do
    send_resp( conn, 404, "{ \"error\": { \"code\": 404, \"message\": \"Route not found.  See config/dispatcher.ex\" } }" )
  end

  match "_", %{ last_call: true, accept: %{ any: true } } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

  last_match
end

