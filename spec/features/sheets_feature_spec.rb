require 'spec_helper'

describe SheetsController do

  it "displays the sheet's title after create" do
    visit "/add"
    fill_in "sheet[name]",  with: "name"
    fill_in "sheet[title]", with: "title"
    fill_in "sheet[text]",  with: "text"
    click_button "add"

    expect(page).to have_selector("h1", text: "title")
  end

  it "subsheet should has p_id eq parent's sheet" do
    sheet = create(:main_sheet)
    visit add_sheet_path(id: sheet.name)

    expect(page).to have_selector("input#sheet_p_id[value='#{sheet.id}']")
  end

  it "displays the new sheet's title after update" do
    sheet = create(:main_sheet, title: "old_title")
    visit edit_sheet_path(id: sheet.to_param)
    fill_in "sheet[name]",  with: "new_name"
    fill_in "sheet[title]", with: "new_title"
    fill_in "sheet[text]",  with: "text"
    click_button "add"

    expect(page).to have_selector("h1", text: "new_title")
  end

end