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
    end

    it "shows the saved value in the input's format" do
      invoice = Invoice.first_or_create!
      visit edit_admin_invoice_path(invoice)

      expect(picker_input.value).to eq(invoice.updated_at.strftime("%Y-%m-%dT%H:%M"))
    end
  end

  context "with a step in seconds" do
    before do
      register_page(Invoice) do
        form do |f|
          f.input :updated_at, as: :date_time_picker, input_html: { step: 1 }
          f.actions
        end
      end
    end

    it "keeps the saved value's seconds" do
      invoice = Invoice.first_or_create!
      visit edit_admin_invoice_path(invoice)

      expect(find("#invoice_updated_at").value)
        .to eq(invoice.updated_at.strftime("%Y-%m-%dT%H:%M:%S"))
    end
  end
end
