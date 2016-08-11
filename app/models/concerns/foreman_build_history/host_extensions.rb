module ForemanBuildHistory
  module HostExtensions
    extend ActiveSupport::Concern

    included do
      # execute callbacks
      after_build :set_build_start
      before_provision :set_build_finish
    end

    # create or overwrite instance methods...
    def set_build_start
      # binding.pry
      facet.build_started = Time.zone.now

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
