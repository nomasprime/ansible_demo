require 'spec_helper'

describe server('ansible-demo-lb0') do
  describe http('http://ansible-demo-lb0.local') do
    it "proxies upstream using round robin" do
      upstreams = ['10.0.15.20:8484', '10.0.15.21:8484']
      start = current = upstreams.find_index(response.headers['X-Upstream-Addr'])

      2.times do
        upstreams.each_index do |index|
          pointer = (index + start) % upstreams.length
          expect(upstreams[current]).to eq(upstreams[pointer])
          current = upstreams.find_index(response.headers['X-Upstream-Addr'])
        end
      end
    end
  end
end
