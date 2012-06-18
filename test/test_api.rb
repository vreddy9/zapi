require 'helper'

class ZapiTest < Test::Unit::TestCase
    include ZapiTestHelper

    def test_session_not_nil
        actualy = Zapi::Session.new
        assert_not_equal(actualy, nil)
    end
end