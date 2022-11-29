class ApplicationController < ActionController::Base
  def not_implemented
    redirect_back fallback_location: root_path, alert: 'Not implemented yet'
  end
end
