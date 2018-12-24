Rails.application.routes.draw do
  #generate routes for new update show edit destroy
  patch "/update_status" => 'tasks#update_status'
  resources :tasks do
    collection do
      patch :sort
      patch :complete_task
      get :completed
      get :active
      delete :delete_multiple
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
