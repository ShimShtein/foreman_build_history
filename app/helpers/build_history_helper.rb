module BuildHistoryHelper
  def build_history_timeline(facet)
    start_timepoint = { :complete => true, :timestamp => facet.build_started, :status => 'Build started' }
    finish_timepoint = { :complete => facet.build_finished.present?, :timestamp => facet.build_finished || 'not yet', :status => 'Build finished' }

    templates = facet.build_history_templates.map do |template|
      { :complete => true,
        :timestamp => template.request_time,
        :status => "#{template.template_kind} template requested" }
    end

    timeline([start_timepoint] + templates + [finish_timepoint])
  end
end
