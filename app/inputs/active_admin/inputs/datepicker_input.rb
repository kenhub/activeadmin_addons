# ActiveAdmin v4 dropped its jQuery UI datepicker input, which set_datepicker
# maps date columns to. Render a native date field, like v4's date filters do.
class ActiveAdmin::Inputs::DatepickerInput < Formtastic::Inputs::DatePickerInput
end
