class CucumberMonitorController < ApplicationController

  def features
    @features = CucumberMonitor.new.features
  end

  def show_feature
    @feature = CucumberMonitor.new.features.where(name: params[:name])
  end

  def search
    @search_results = CucumberMonitor.new.search(params[:criteria])
  end

end