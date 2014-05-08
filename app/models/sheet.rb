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

  after_save :drop_cache

  private

    def drop_cache
      Rails.cache.delete('sheets')
      Rails.cache.delete(self.name)
      Rails.cache.delete("text_#{self.id}")
    end

end