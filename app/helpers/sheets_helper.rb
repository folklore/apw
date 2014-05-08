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

  # Делаем преобразование текста, не допуская
  # в содержимое какие либо другие теги
  def sanitize_text(text)
    Sanitize.clean(transformation(text),
                   elements: %w(b i a),
                   attributes: { 'a' => ['href'] } )
  end

  def transformation(text)
    # **string**      => <b>string</b>
    # \\string\\      => <i>string</i>
    # ((link anchor)) => <a href="[site]link">anchor</a>

    b_regexp = /\*\*(.+)\*\*/m
    i_regexp = /\\\\(.+)\\\\/m
    a_regexp = /\(\(([a-z\/A-Z0-9_а-яёА-ЯЁ]+)\s(.+?)\)\)/

    exit = false

    # Собственно функция циклично будет обходить весь текст
    # страницы пока не останется ни одного элемента, который
    # нужно преобразовать согласно заданию
    until exit do
      if not (b = text.match(b_regexp)).nil?
        text.sub!(b_regexp, "<b>#{b[1]}</b>")
      elsif not (i = text.match(i_regexp)).nil?
        text.sub!(i_regexp, "<i>#{i[1]}</i>")
      elsif not (a = text.match(a_regexp)).nil?
        text.sub!(a_regexp, "<a href='/#{a[1]}'>#{a[2]}</a>")
      else
        exit = true
      end
    end

    return text
  end

end