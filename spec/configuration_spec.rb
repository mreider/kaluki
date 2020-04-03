require 'spec_helper'
RSpec.configure do |config|
    config.after(:all) do
        redis = Redis.new
        redis.flushdb
    end
end