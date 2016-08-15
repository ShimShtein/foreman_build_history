module ForemanBuildHistory
  module UnattendedControllerExtensions
    extend ActiveSupport::Concern

    included do
      after_filter :update_template_timestamp, only: :host_template, unless: -> { preview? }
    end

    def update_template_timestamp
      facet = @host.build_history_facet || @host.build_build_history_facet

      facet.build_history_templates.build(request_time: Time.zone.now, template_kind: params[:kind])
      facet.save!
    end
  end
end
