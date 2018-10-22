require 'k7'
module K7
  module Testing
    def self.reset!
      K7.reset_observers!
      @@last_response = nil
      @@last_request = nil
    end

    def self.last_request=(v)
      @@last_request = v
    end

    def self.last_response=(v, _)
      @@last_response = v
    end

    def self.last_request
      @@last_request
    end

    def self.last_response
      @@last_response
    end
  end
end

RSpec.configure do |config|
  config.before(:each) do
    K7::Testing.reset!
    K7.register_observer(:response, K7::Testing, :last_response=)
    K7.register_observer(:request, K7::Testing, :last_request=)
  end
end
