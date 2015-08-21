Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :employees, :except => [:edit, :new]
      resources :vacancies, :except => [:edit, :new]
      resources :skills, :only => :index
    end
  end

end
