require 'k7'
require 'k7/net_http'
require 'faraday'
module K7
  module Hooks
    class Faraday
      def self.install!
        if ::Faraday.default_adapter == :net_http
          NetHttp.install!
        else
          raise "Don't know how to handle faraday default_adapter '#{::Faraday.default_adapter}'"
        end
      end
    end
  end
end
