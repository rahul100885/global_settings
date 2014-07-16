require 'test_helper'

class ConfigStoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should return nil if key not exists" do
    assert_nil ConfigStore['not_set']
  end

  test "should return stored values" do
    ConfigStore['email'] = "rahul@example.com"
    assert_equal("rahul@example.com", ConfigStore['email'])

    ConfigStore['count'] = 1
    assert_equal(1, ConfigStore['count'])
    
    ConfigStore['float'] = 1.1
    assert_equal(1.1, ConfigStore['float'])
    
    ConfigStore['email_notify'] = true
    assert_equal(true, ConfigStore['email_notify'])
    
    ConfigStore['sms_notify'] = false
    assert_equal(false, ConfigStore['sms_notify'])
  end
end
