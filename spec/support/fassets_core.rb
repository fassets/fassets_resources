require "fassets_core/test_helper"

# override params request additional params to use route of the engine
module FassetsCore::TestHelpers
  def additional_request_params
    { :use_route => :fassets_resources }
  end
end
