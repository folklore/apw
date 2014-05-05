require 'spec_helper'

describe "sheets/new" do
  it "h1 should contain parent's title" do
    sheet = create(:main_sheet)
    assign(:sheet, sheet)

    render template: "sheets/edit"
    rendered.should have_selector("h1", content: "Редактирование страницы #{sheet.title}")
  end

  it "should render an 'update' form" do
    sheet = create(:main_sheet)
    assign :sheet, sheet
    render template: "sheets/edit"
    view.should render_template(partial: "_form")
    rendered.should have_selector "form[action='#{update_path(id: sheet.id)}']"
  end
end