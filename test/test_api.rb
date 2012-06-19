require 'helper'

class ZapiTest < Test::Unit::TestCase
    include ZapiTestHelper

    def test_session_not_nil
        actualy = Zapi::Session.new(username: 'smogger914@yahoo.com', password: 'Fo!d3168')
        assert_not_equal(actualy, nil)
    end
end