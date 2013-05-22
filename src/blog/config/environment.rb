# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Blog::Application.initialize!

# use MultiDb
#MultiDb::ConnectionProxy.setup!
if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    if forked
      # ... set MultiDb configuration options, if any ...
      MultiDb::ConnectionProxy.setup!
    end
  end
else # not using passenger (e.g. development/testing)
  # ... set MultiDb configuration options, if any ...
  MultiDb::ConnectionProxy.setup!
end