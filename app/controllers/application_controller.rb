class ApplicationController < ActionController::Base
  def not_implemented
    render :head
  end
end
