require 'spec_helper'

describe "layouts/application" do
  it "should contain sheets' tree" do
    sheet1 = create(:sheet, p_id: nil)
    sheet11 = create(:sheet, p_id: sheet1.id)
    sheet111 = create(:sheet, p_id: sheet11.id)

    assign(:sheets, Sheet.all_cache)

    render template: "sheets/index", layout: "layouts/application"

    rendered.should have_selector("table tbody tr td ul li ul li ul li a")
  end

  it 'should contain link to new sheet' do
    sheet1 = create(:sheet, p_id: nil)
    sheet11 = create(:sheet, p_id: sheet1.id)
    sheet111 = create(:sheet, p_id: sheet11.id)

    assign(:sheets, Sheet.all_cache)

    render template: "sheets/index", layout: "layouts/application"

    expect(rendered).to include('<a href="/add">Добавление страницы</a>')
  end
end