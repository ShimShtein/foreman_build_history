class BuildHistoryFacet < ActiveRecord::Base
  belongs_to_host

  has_many :build_history_templates, dependent: :destroy
end
