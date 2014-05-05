require 'spec_helper'

describe SheetsHelper do

  it "menu" do
    sheet1 = create(:main_sheet, title: 'sheet1')
    sheet11 = create(:sheet, title: 'sheet11', p_id: sheet1.id)
    sheet111 = create(:sheet, title: 'sheet111', p_id: sheet11.id)

    expect(helper.menu(sheet1)).to include(sheet1.title, sheet11.title, sheet111.title)
    expect(helper.menu(sheet1)).to include(sheet1.to_param, sheet11.to_param, sheet111.to_param)
  end

end