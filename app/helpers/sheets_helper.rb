module SheetsHelper

  def menu(sheet)
    # http://api.rubyonrails.org/classes/ActionView/Helpers/TextHelper.html#method-i-concat

    content_tag :li do
      concat link_to(sheet.title, sheet).html_safe

      # Если страница имеет дочерние страницы,
      # то выводим все её подстраницы ввиде ul меню
      # через этот же метод "menu"
      if sheet.children.present?
        concat content_tag(:ul){
          sheet.children.each { |child|
            concat menu(child)
          }
        }
      end

    end
  end

end