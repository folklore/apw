Wiki::Application.routes.draw do

  # При обнавлении не можем опираться на name страницы,
  # так как его можно менять, но если атрибуты страницы
  # не пройдут валидацию, мы получим форму, у которой
  # путь содержит новое name страницы, которого ещё нет в
  # базе данных.
  match ':id' => 'sheets#update', via: [:put, :patch], as: :update

  # expect - убираем из ресурного маршрута не нужные сегменты
  # path - переопределяем автоматически создаваемый путь машрута,
  #        на не обязательный динамический сегмент
  # path_names - переопределяем автоматически создаваемый сегмент new
  resources :sheets,
             except: [:index, :update, :destroy],
             path: '(/*parent_names)',
             path_names: { new: 'add' } do
    # Добавляем маршрут к странице, необходим для создания привязанной
    # страницы (подстраницы), и направляем его на сегмент new
    get :add,
         action: :new,
         on: :member
  end

  root 'sheets#index'

end