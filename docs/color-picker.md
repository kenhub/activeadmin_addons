# Color Picker

## Form

Renders the browser's native color input (`<input type="color">`). The palette
is offered as suggestions through a `<datalist>`; browsers without datalist
support for color inputs show their plain picker.

```ruby
form do |f|
  f.inputs "Details" do
    f.input :color, as: :color_picker
  end

  f.actions
```

A native color input always holds a color, so a blank attribute is saved as
`#000000` once the form is submitted.

## Options

* `palette`: If you don't want default, you can pass your own colors:

```ruby
form do |f|
  f.inputs "Details" do
    f.input :color, as: :color_picker, palette: ["#DD2900","#D94000","#D55500","#D26A00","#CE7D00","#CA9000","#C6A300","#C2B400","#B9BF00"]
  end

  f.actions
```
