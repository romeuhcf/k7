require "k7/version"

module K7
  def self.emit_request(req)
    Testing.last_request = req
  end

  def self.emit_response(response, request)
    Testing.last_response = response
  end

  def self.uri_to_hash(uri)
    {
      scheme: uri.scheme,
      host: uri.host,
      port: uri.port,
      path: uri.path,
      query: uri.query,
      fragment: uri.fragment,
    }
  end


  def self.canonicalize_headers(h)
    headers = {}
    h.each do |k, v|
      headers[canonicalize_key(k)] = v
    end
    headers
  end

  def self.canonicalize_key(k)
    k.downcase
  end


  module Testing
    def self.reset!
      @@lest_response = nil
      @@lest_request = nil
    end
    [ :last_request ,:last_response].each do |att|
      eval "@@#{att}=nil"
      eval "def self.#{att}=(v); @@#{att} = v ; end "
      eval "def self.#{att}; @@#{att} ; end "
    end
  end
end
