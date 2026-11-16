# Date Time Picker

## Form

Renders the browser's native `datetime-local` input, with the value as `YYYY-MM-DDTHH:MM`, plus seconds and milliseconds when the saved value has them.

```ruby
form do |f|
  f.inputs "Details" do
    f.input :updated_at, as: :date_time_picker
  end

  f.actions
```

## Options

`picker_options`, `config.datetime_picker_default_options` and
`config.datetime_picker_input_format` configured the former jQuery picker and
are ignored. Use HTML attributes instead, e.g.
`input_html: { min: "2024-01-01T00:00", step: 900 }`.
