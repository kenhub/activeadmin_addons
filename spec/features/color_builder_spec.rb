require "rails_helper"

describe "Color Builder", type: :feature do
  context "Form" do
    def color_input
      find("#invoice_color")
    end

    def palette
      all("datalist#invoice_color_palette option", visible: false).map(&:value)
    end

    context "with default palette" do
      before do
        register_page(Invoice) do
          form do |f|
            f.inputs "Details" do
              f.input :color, as: :color_picker
            end

            f.actions
          end
        end

        visit new_admin_invoice_path
      end

      it "shows a native color input" do
        expect(color_input[:type]).to eq("color")
        expect(color_input[:list]).to eq("invoice_color_palette")
      end

      it "suggests the default palette" do
        expect(palette).to eq(ColorPickerInput::DEFAULT_PALETTE)
      end
    end

    context "with custom palette" do
      before do
        register_page(Invoice) do
          form do |f|
            f.inputs "Details" do
              f.input :color, as: :color_picker, palette: ["#FF9900"]
            end

            f.actions
          end
        end

        visit new_admin_invoice_path
      end

      it "suggests the custom palette" do
        expect(palette).to eq(["#FF9900"])
      end
    end
  end
end
