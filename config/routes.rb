Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :users, only: %i[show create]
    end
  end
end
