Rails.application.routes.draw do
  #generate routes for new update show edit destroy
  resources :tasks do
    collection do
      patch :sort
      delete :delete_multiple
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
