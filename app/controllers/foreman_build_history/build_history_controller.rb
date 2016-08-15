module ForemanBuildHistory
  class BuildHistoryController < ApplicationController
    # change layout if needed
    # layout 'foreman_build_history/layouts/new_layout'

    def index
      @history_facets = BuildHistoryFacet.all
    end
  end
end
