require 'test_plugin_helper'

class UnattendedControllerExtensionsTest < ActionController::TestCase
  tests UnattendedController

  test 'should record a new unattended access' do
    ptable = FactoryGirl.create(
      :ptable,
      :name => 'default',
      :operatingsystem_ids => [operatingsystems(:redhat).id]
    )

    rh_host = FactoryGirl.create(
      :host, :managed, :with_dhcp_orchestration,
      :build => true,
      :operatingsystem => operatingsystems(:redhat),
      :ptable => ptable,
      :medium => media(:one),
      :architecture => architectures(:x86_64)
    )

    @request.env['HTTP_X_RHN_PROVISIONING_MAC_0'] = "eth0 #{rh_host.mac}"

    assert_difference 'BuildHistoryTemplate.count' do
      get :host_template, :kind => 'provision'
    end
    assert_response :success
    rh_host.reload
    assert_equal 'provision', rh_host.build_history_facet.build_history_templates.first.template_kind
  end
end
