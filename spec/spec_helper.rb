require 'bundler/setup'
require 'simplecov'
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
require 'coveralls'
Coveralls.wear!
SimpleCov.start
require 'k7'

RSpec.configure do |config|
  def base_url
    'https://jsonplaceholder.typicode.com'
    'http://127.0.0.1:8000'
  end
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.before(:each) { K7::Testing.reset! }
  config.after(:each) { K7::Testing.reset! }
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.order = :random
end
