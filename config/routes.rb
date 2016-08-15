Rails.application.routes.draw do
  get 'build_history', to: 'foreman_build_history/build_history#index'
end
