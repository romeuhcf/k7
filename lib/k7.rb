require 'k7/version'

module K7

  def self.reset_observers!
    @@observers = {}
  end

  def self.emit_request(req)
    notify(:request, req)
  end

  def self.emit_response(response, request)
    notify(:response, response, request)
  end

  def self.notify(kind, *obj)
    observers(kind).each do |tuple|
      receiver, method = *tuple
      receiver.send(method, *obj)
    end
  end

  def self.register_observer(kind, klass, method = :notify)
    observers(kind) << [klass, method]
  end

  def self.observers(kind)
    fail "invalid observer kind '#{kind}'" unless [:request, :response].include?(kind)
    @@observers ||= {}
    @@observers[Thread.current]||={}
    @@observers[Thread.current][kind] ||= []
  end

  def self.uri_to_hash(uri)
    {
      scheme: uri.scheme,
      host: uri.host,
      port: uri.port,
      path: uri.path,
      query: uri.query,
      fragment: uri.fragment
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
end

