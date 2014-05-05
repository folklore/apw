require 'spec_helper'

describe "sheets/show" do
  it "should contain sub sheets' tree" do
    sheet1 = create(:main_sheet)
    sheet11 = create(:sheet, p_id: sheet1.id)
    sheet111 = create(:sheet, p_id: sheet11.id)

    assign(:sheets, Sheet.all_cache)
    assign(:sheet, sheet1)

    render template: "sheets/show", layout: "layouts/application"

    rendered.should have_selector("table tbody tr td.submenu ul li ul li a")
  end

  it 'should contain link to edit sheet' do
    sheet1 = create(:main_sheet)

    assign(:sheets, Sheet.all_cache)
    assign(:sheet, sheet1)

    render template: "sheets/show", layout: "layouts/application"

    expect(rendered).to include(link_to 'Редактирование страницы', edit_sheet_path(sheet1))
  end

  it 'should contain link to add sub sheet' do
    sheet1 = create(:main_sheet)

    assign(:sheets, Sheet.all_cache)
    assign(:sheet, sheet1)

    render template: "sheets/show", layout: "layouts/application"

    expect(rendered).to include(link_to 'Добавление подстраницы', add_sheet_path(sheet1))
  end

end