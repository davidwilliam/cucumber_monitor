module ApplicationHelper
  def step_result(status)
  	I18n.t("results.#{status}")
  end
end
