class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

private

  def current_session
    @current_session ||= Workshare::Client.default_cookies[:device_credentials]
  end
  helper_method :current_session

  def session_required
    unless current_session
      redirect_to root_path, flash: { errors: 'Login required' } and return
    end
  end
end
