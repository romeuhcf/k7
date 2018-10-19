require 'typhoeus'
require 'k7'
module K7
  module Hooks
    class Typhoeus
      def initialize
        @memory = {}
      end

      def get(_request)
        nil
      end

      def set(request, response)
        K7.emit_request(req = k7_request(request))
        K7.emit_response(k7_response(response), req)
        nil
      end

      def k7_request(req)
        uri = URI.parse(req.base_url)
        k7_uri = K7.uri_to_hash(uri)
        OpenStruct.new(_request: req,
                       uri: k7_uri,
                       query_params: CGI.parse(k7_uri[:query] || ''),
                       params: req.options[:params],
                       verb: req.options.fetch(:method).to_s.downcase,
                       headers: K7.canonicalize_headers(req.options.fetch(:headers)),
                       body: req.encoded_body,
                       emiter: 'typhoeus')
      end

      def k7_response(res)
        headers = K7.canonicalize_headers(res.headers)
        OpenStruct.new(status: res.response_code,
                       headers: headers,
                       body: res.body,
                       emiter: 'typhoeus')
      end

      protected

      def self.install!
        ::Typhoeus::Config.cache = K7::Hooks::Typhoeus.new
      end
    end
  end
end
