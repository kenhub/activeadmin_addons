require "rails_helper"

describe "Date Time Picker Input", type: :feature do
  context "Form" do
    def picker_input
      find("#invoice_updated_at")
    end

    before do
      register_page(Invoice) do
        form do |f|
          f.input :updated_at, as: :date_time_picker
          f.actions
        end
      end
    end

    it "shows a native date and time input" do
      visit new_admin_invoice_path

      expect(picker_input[:type]).to eq("datetime-local")
      expect(picker_input[:class]).to include("date-time-picker-input")
      expect(picker_input[:step]).to eq("any")
    end

    def edit_invoice_updated_at(time)
      invoice = Invoice.first_or_create!
      invoice.update_column(:updated_at, Time.zone.parse(time))
      visit edit_admin_invoice_path(invoice)
    end

    it "leaves out the seconds of a whole minute" do
      edit_invoice_updated_at("2024-05-06 10:30:00")

      expect(picker_input.value).to eq("2024-05-06T10:30")
    end

    it "keeps the saved value's seconds" do
      edit_invoice_updated_at("2024-05-06 10:30:15")

      expect(picker_input.value).to eq("2024-05-06T10:30:15")
    end

    it "keeps the saved value's milliseconds" do
      edit_invoice_updated_at("2024-05-06 10:30:15.25")

      expect(picker_input.value).to eq("2024-05-06T10:30:15.250")
    end
  end

  context "with a step" do
    before do
      register_page(Invoice) do
        form do |f|
          f.input :updated_at, as: :date_time_picker, input_html: { step: 900 }
          f.actions
        end
      end
    end

    it "keeps the given step" do
      visit new_admin_invoice_path

      expect(find("#invoice_updated_at")[:step]).to eq("900")
    end
  end
end
