Rails.application.routes.draw do
  resource :cucumber_monitor, only: [] do 
  	get '/' => 'cucumber_monitor#features', as: 'features'
    get 'features' => 'cucumber_monitor#features', as: 'features'
    get 'show_feature/:name' => 'cucumber_monitor#show_feature', as: 'show_feature'
    get 'search' => 'cucumber_monitor#search', as: 'search'
    get 'feature_runner/:name' => 'cucumber_monitor#feature_runner', as: 'feature_runner'
  end
end
