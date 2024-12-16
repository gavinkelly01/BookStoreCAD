Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users
  
  # Books routes
  resources :books do
    # Nested reviews routes
    resources :reviews, only: [:index, :show, :create, :update, :destroy]
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Root route (you can change this to any other controller action, such as the home page)
  # Adjust if you want to change the home page

  # You can also add any other custom routes here if needed
end
