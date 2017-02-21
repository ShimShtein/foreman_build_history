module ForemanBuildHistory
  class BuildHistoryController < ApplicationController
    def index
      @history_facets = BuildHistoryFacet.all
    end
  end
end
