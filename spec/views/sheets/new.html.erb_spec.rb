require 'spec_helper'

describe "sheets/new" do
  it "h1 should contain parent's title" do
    sheet = create(:main_sheet)
    assign(:sheet, build(:sheet, p_id: sheet.id))

    render template: "sheets/new"
    rendered.should have_selector("h1", content: "Добавление подстраницы к #{sheet.title}")
  end

  it "should render a 'create' form" do
    assign :sheet, build(:main_sheet)
    render template: "sheets/new"
    view.should render_template(partial: "_form")
    rendered.should have_selector "form[action='#{sheets_path}']"
  end
end