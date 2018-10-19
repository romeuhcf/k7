require 'spec_helper'
require 'k7/typhoeus'

K7::Hooks::Typhoeus.install!

RSpec.describe 'Typhoeus' do
  let(:body) { 'a body' }
  let(:params) { { title: 'new title' } }
  let(:get) { Typhoeus.get("#{base_url}/todos/1?foo=bar") }
  let(:head) { Typhoeus.head("#{base_url}/todos/1?foo=bar") }
  let(:put) { Typhoeus.put("#{base_url}/todos/1?foo=bar", body: body, params: params) }
  let(:patch) { Typhoeus.patch("#{base_url}/todos/1?foo=bar", body: body, params: params) }
  let(:post) { Typhoeus.post("#{base_url}/todos?foo=bar", body: body, params: params) }
  let(:delete) { Typhoeus.delete("#{base_url}/todos/1?foo=bar") }
  let(:options) { Typhoeus.options("#{base_url}/todos/1?foo=bar") }

  verbs = [:get, :head, :put, :patch, :post, :delete, :options]
  it_behaves_like 'k7_driver', verbs, 'typhoeus'
end
