require 'spec_helper'
require 'k7/faraday'

K7::Hooks::Faraday.install!

RSpec.describe "Faraday" do

  # Typhoeus.get("www.example.com")
  # Typhoeus.head("www.example.com")
  # Typhoeus.put("www.example.com/posts/1", body: "whoo, a body")
  # Typhoeus.patch("www.example.com/posts/1", body: "a new body")
  # Typhoeus.post("www.example.com/posts", body: { title: "test post", content: "this is my test"})
  # Typhoeus.delete("www.example.com/posts/1")
  # Typhoeus.options("www.example.com")

  let(:body) { "a body" }
  let(:params) { {title: "new title" } }
  let(:get) { Faraday.get("#{base_url}/todos/1?foo=bar") }
  let(:head) { Faraday.head("#{base_url}/todos/1?foo=bar") }
  let(:put) { Faraday.put("#{base_url}/todos/1?foo=bar", body: body, params: params) }
  let(:patch) { Faraday.patch("#{base_url}/todos/1?foo=bar", body: body, params: params ) }
  let(:post) { Faraday.post("#{base_url}/todos?foo=bar", body: body, params: params ) }
  let(:delete) { Faraday.delete("#{base_url}/todos/1?foo=bar") }
  #let(:options){Faraday.options("#{base_url}") }
  verbs = [:get, :head, :put, :patch, :post, :delete] #, :options]
  it_behaves_like "k7_driver", verbs, 'net_http'
end
