class Sheet < ActiveRecord::Base

  # Заменяем стандартные указатель (id) страницы
  # в URL сегментах на нужный по заданию
  def to_param
    (parent_names << name).join('/')
  end

  validates :name,
             format: { with: /\A[a-zA-Zа-яёА-ЯЁ0-9_]+\Z/ },
             uniqueness: true,
             presence: true

  validates :title, :text,
             presence: true

  validates :p_id,
             numericality: { only_integer: true,
                             greater_than: 0 },
             allow_blank: true

  belongs_to :parent, -> { includes(:parent) },
              class_name: 'Sheet',
              foreign_key: :p_id

  has_many :children, -> { includes(:children, :parent).order('id ASC') },
            class_name: 'Sheet',
            foreign_key: :p_id

  def parent_names
    array = [ ]

    # self - это наша страница, если у неё есть родительская страница,
    if self.parent.present?
      # то мы вытаскиваем её name и при этом не забываем посмотреть
      # нет ли у нашей родительской страницы своя родительская страница
      # и делаем это путем рекурсии на функцию в которой сейчас находимся
      array = self.parent.parent_names << self.parent.name
    end
    # Если же у страницы на которую вызвали данную функцию нет родительской страницы,
    # то мы возвращаем пустой массив,
    # иначе возвращаем массив с именем родительской страницы

    return array
  end

  # кеш всех main страниц
  # (те что не имеют родитесльких страниц)
  def self.all_cache
    Rails.cache.fetch('sheets') { includes(:children)
                                 .where(p_id: nil)
                                 .order('id ASC').to_a }
  end

  # кеш единичной страницы
  def self.one_cache(name)
    Rails.cache.fetch(name) { where(name: name)
                             .includes(:parent, :children)
                             .first }
  end

  # Делаем преобразование текста, не допуская
  # в содержимое какие либо другие теги
  def sanitize_text
    Rails.cache.fetch("text_#{id}") {
      Sanitize.clean(transformation,
                     elements: %w(b i a),
                     attributes: { 'a' => ['href'] } )
    }
  end

  def transformation
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

  after_save :drop_cache

  private

    def drop_cache
      Rails.cache.delete('sheets')
      Rails.cache.delete(self.name)
      Rails.cache.delete("text_#{self.id}")
    end

end