require 'test_plugin_helper'

class BuildHistoryHostExtensionsTest < ActiveSupport::TestCase
  test 'build start time is recorded' do
    host = FactoryGirl.create(:host, :managed, :build => false)

    host.build = true
    host.save!

    assert_not_nil host.build_history_facet.build_started
  end

  test 'build finish time is recorded' do
    host = FactoryGirl.create(:host, :managed, :build => true)

    host.build = false
    host.save!

    assert_not_nil host.build_history_facet.build_finished
  end
end
