require 'spec_helper'
require 'k7/net_http'

K7::Hooks::NetHttp.install!
RSpec.describe "Net::HTTP" do
  it {expect(Net::HTTP).to respond_to(:k7?) }
  it {expect(Net::HTTP.k7?).to be true }

  let(:uri) { URI.parse( "#{base_url}/todos/1?foo=bar")}
  let(:get) { Net::HTTP.get_response(uri) }
  let(:head) { Net::HTTP.start(uri.host, uri.port){|http|  response = http.head(uri.path) } }
  let(:put) {
    Net::HTTP.start(uri.host, uri.port){|http|
      request = Net::HTTP::Put.new(uri.path)
      request.set_form_data(title: 'a new title')
      response = http.request(request)
    }
  }

  let(:patch) {
    Net::HTTP.start(uri.host, uri.port){|http|
      request = Net::HTTP::Patch.new(uri.path)
      request.set_form_data(title: 'a new title')
      response = http.request(request)
    }
  }

  let(:post) {
    # {params: { title: "test post", content: "this is my test" }}
    Net::HTTP.start(uri.host, uri.port){|http|
      request = Net::HTTP::Post.new(uri.path)
      request.set_form_data(title: 'a new title')
      response = http.request(request)
    }
  }

  let(:delete) {
    Net::HTTP.start(uri.host, uri.port){|http|
      request = Net::HTTP::Delete.new(uri.path)
      response = http.request(request)
    }
  }

  verbs = [:get, :head  , :put , :patch, :post, :delete]
  it_behaves_like "k7_driver", verbs, 'net_http'
  it {expect(get.body).to include '<title>'}
end
