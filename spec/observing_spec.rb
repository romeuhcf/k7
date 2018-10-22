require 'spec_helper'
require 'k7'

class DummyObserver
  def self.reset_evts!
    @@_evts = []
  end

  def self.events_observed
    @@_evts ||= []
  end

  def notify(evt)
    puts "evt.class #{evt.class}"
    @@_evts << evt
  end
end

RSpec.describe "K7" do
  def observed_events
    DummyObserver.events_observed.count
  end

  def request_emitted
    K7.emit_request(double)
  end

  before(:each) do |e|
    puts ">>>#{e} resetting"
    DummyObserver.reset_evts!
    10.times do
        K7.register_observer(:request, DummyObserver.new, :notify)
    end
  end

  it { expect(K7.observers(:request).count).to eq 10 + 1}
  it { expect{request_emitted}.to change{observed_events}.by(10) }
end
