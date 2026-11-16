# The MIT License (MIT)
#
# Copyright (c) 2015 Igor Fedoronchuk
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Renders a native datetime-local input; picker_options and the
# datetime_picker_* settings belonged to the removed jQuery picker.
class DateTimePickerInput < ActiveAdminAddons::InputBase
  def load_control_attributes
    load_class(@options[:class])
    load_attr(:type, value: "datetime-local")
    load_attr(:autocomplete, value: 'off')
    load_attr(:value, value: formatted_input_value)
  end

  def formatted_input_value
    v = input_value
    return v.strftime(value_format) if v.respond_to?(:strftime)

    v.to_s
  end

  private

  # seconds unless the step is in whole minutes (60 when unset); at such a
  # step a value with seconds would fail the browser's validation
  def value_format
    step = @options.dig(:input_html, :step)
    seconds = step.nil? ? 60 : Float(step.to_s, exception: false)
    return "%Y-%m-%dT%H:%M" if seconds && (seconds % 60).zero?

    "%Y-%m-%dT%H:%M:%S"
  end
end
