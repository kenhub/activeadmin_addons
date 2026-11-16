# Date Time Picker

## Form

Renders the browser's native `datetime-local` input, with the value as `YYYY-MM-DDTHH:MM`, plus seconds and milliseconds when the saved value has them. The `step` defaults to `any`, so any value passes the browser's validation; pass `input_html: { step: }` to restrict it.

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
