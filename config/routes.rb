Rails.application.routes.draw do
  get 'new_action', to: 'foreman_build_history/hosts#new_action'
end
