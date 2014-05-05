require 'spec_helper'

describe "sheets/_form" do
  it "renders the form partial for create" do
    sheet = build(:main_sheet)
    assign(:sheet, sheet)

    render

    rendered.should have_selector('form', method: "post", action: sheets_path) do |form|
      form.should have_selector('label',    for: 'sheet_name', content: 'Имя (сслыка)')
      form.should have_selector('input',    type: "text", name: 'sheet[name]', id: 'sheet_name', value: sheet.name)

      form.should have_selector('label',    for: 'sheet_title', content: 'Заголовок')
      form.should have_selector('input',    type: "text", name: 'sheet[title]', id: 'sheet_title', value: sheet.title)

      form.should have_selector('label',    for: 'sheet_text', content: 'Текст')
      form.should have_selector('textarea', name: 'sheet[text]', id: 'sheet_text', content: sheet.text)

      form.should have_selector('input',    type: "hidden", name: 'sheet[p_id]', id: 'sheet_p_id')

      form.should have_selector('input',    type: 'submit', value: 'Добавить страницу')
    end
  end

  it "renders the form partial for edit" do
    sheet = create(:main_sheet)
    assign(:sheet, sheet)

    render

    rendered.should have_selector("form[action='#{update_path(id: sheet.id)}']") do |form|
      form.should have_selector('input', type: 'submit', value: 'Отредактировать страницу')
    end
  end

  it "renders the form partial for child create" do
    sheet = create(:main_sheet)
    child = build(:sheet, p_id: sheet.id)
    assign(:sheet, child)

    render

    rendered.should have_selector("form[action='#{sheets_path}']") do |form|
      form.should have_selector('input', type: "hidden", name: 'sheet[p_id]', id: 'sheet_p_id', value: "#{sheet.id}")
    end
  end

  it "renders the form partial for child edit" do
    sheet = create(:main_sheet)
    child = create(:sheet, p_id: sheet.id)
    assign(:sheet, child)

    render

    rendered.should have_selector("form[action='#{update_path(id: child.id)}']") do |form|
      form.should have_selector('input', type: "hidden", name: 'sheet[p_id]', id: 'sheet_p_id', value: "#{sheet.id}")
    end
  end
end