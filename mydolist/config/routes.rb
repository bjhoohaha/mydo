Rails.application.routes.draw do
  #generate routes for new update show edit destroy
  patch "/update_status" => 'tasks#update_status'
  resources :tasks do
    collection do
      get :completed
      get :active
      get :time_remaining
      get :delete_tasks
      patch :sort
      patch :complete_task
      patch :bookmark_task
      patch :update_time
      delete :destroy_multiple
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
