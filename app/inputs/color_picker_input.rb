class ColorPickerInput < ActiveAdminAddons::InputBase
  DEFAULT_PALETTE = [
    "#000000",
    "#333333",
    "#663300",
    "#CC0000",
    "#CC3300",
    "#FFCC00",
    "#009900",
    "#006666",
    "#0066FF",
    "#0000CC",
    "#663399",
    "#CC0099",
    "#FF9999",
    "#FF9966",
    "#FFFF99",
    "#99FF99",
    "#66FFCC",
    "#99FFFF",
    "#66CCFF",
    "#9999FF",
    "#FF99FF",
    "#FFCCCC",
    "#FFCC99",
    "#FFFFFF"
  ]

  # a native color input, with the palette offered as suggestions
  def render_custom_input
    concat(label_html)
    concat(builder.color_field(method, input_html_options.merge(list: palette_id)))
    concat(palette_list)
  end

  private

  def palette_id
    "#{input_html_options[:id]}_palette"
  end

  def palette_list
    palette = calculate_attr_value(:palette, default: DEFAULT_PALETTE)
    options = palette.map do |color|
      template.content_tag(:option, nil, value: color)
    end
    template.content_tag(:datalist, template.safe_join(options), id: palette_id)
  end
end
