module TimelineHelper
  def timeline(timepoints)
    content_tag :ul, :class => 'timeline' do
      points_html = timepoints.map { |point| timepoint(point) }
      safe_join points_html
    end
  end

  def timepoint(opts = {})
    content_tag :li, :class => 'li' + (opts[:complete] ? ' complete' : '') do
      result = []

      result << content_tag(:div, opts[:timestamp], :class => 'timestamp') if opts[:timestamp]

      result << content_tag(:div, opts[:status], :class => 'status') if opts[:status]

      safe_join result
    end
  end
end
