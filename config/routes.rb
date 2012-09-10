Rails.application.routes.draw do
  resource :cucumber_monitor, only: [] do 
    get 'features' => 'cucumber_monitor#features', as: 'features'
    get 'show_feature/:name' => 'cucumber_monitor#show_feature', as: 'show_feature'
    get 'search' => 'cucumber_monitor#search', as: 'search'
  end
end
