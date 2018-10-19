require 'rack'

module MyApp
  module Test
    class Server
      def call(env)
          [ 200, {'Content-Type' => 'text/plain'}, "<title>foo</title>" ]
      end
    end
  end
end

@server_thread = Thread.new do
  Rack::Handler::Thin.run MyApp::Test::Server.new, :Port => 8000
end
sleep(1)
