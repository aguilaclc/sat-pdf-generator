Rails.application.routes.draw do
  root 'application#index'

  post 'pdf', to: 'application#pdf'
end
