Rails.application.routes.draw do
	
  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_scope :user do
	  root to: "devise/sessions#new"
	end
	get 'users/:id' => 'users#show', as: :user
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :secret_codes
end
