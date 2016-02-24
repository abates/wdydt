require_relative "controller_macros"
require_relative "helper_macros"

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller
  config.include HelperMacros, :type => :helper
end
