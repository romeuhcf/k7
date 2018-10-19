require 'net/http'
require 'yaml'
module K7
  module Hooks
    module NetHttp
      OriginalNetHTTP = Net::HTTP unless const_defined?(:OriginalNetHTTP)

      @k7NetHTTP = Class.new(::Net::HTTP) do
        def transport_request(req)
          already_k7 = is_already_k7?(req)

          if already_k7
            return super(req)
          end
          k7_req = k7_request(req)
          K7.emit_request(k7_req)

          super(req).tap do |res|
            k7_res = k7_response(res)
            K7.emit_response(k7_res, k7_req)
          end
        end

        def is_already_k7?(req)
          req.each_header{|k,v| return true if k == 'x-k7' }
          false
        end

        def k7_request(req)
          headers = {}
          req.each_header{|k, v| headers[k] = v }

          uri = URI.parse(['http', use_ssl? && 's', '://', address, ':', port, req.path].compact.join)
          k7_uri = K7.uri_to_hash(uri)
          OpenStruct.new(
            _request: req,
            params: nil,
            query_params: CGI::parse(k7_uri[:query]||''),
            uri: k7_uri,
            verb: req.method.to_s.downcase,
            headers: K7.canonicalize_headers(headers),
            body: (req.body || '' rescue '')
          )
        end

        def k7_response(res)
          headers = {}
          res.each_header{|k, v| headers[k] = v }
          OpenStruct.new(
            emiter: 'net_http',
            status: res.code.to_i,
            headers: headers,
            body: res.body || ''
          )
        end

        class << self
          def k7?
            true
          end
        end
      end

      def self.install!
        ::Net.send(:remove_const, :HTTP)
        ::Net.send(:const_set, :HTTP, @k7NetHTTP)
      end
    end
  end
end
