module ForemanBuildHistory
  module HostExtensions
    extend ActiveSupport::Concern

    included do
      # execute callbacks
      after_build :set_build_start
      before_provision :set_build_finish
      before_save :build_history_handle_host_creation
      has_one :build_history_facet, :foreign_key => 'host_id'
    end

    def build_history_handle_host_creation
      return unless build?

      set_build_start
    end

    # create or overwrite instance methods...
    def set_build_start
      return if facet.build_started

      facet.build_started = Time.zone.now
      facet.build_history_templates.delete_all

      facet.save unless facet.new_record?
    end

    def set_build_finish
      facet.build_finished = Time.zone.now

      facet.save unless facet.new_record?
    end

    def facet
      build_history_facet || build_build_history_facet
    end
  end
end
