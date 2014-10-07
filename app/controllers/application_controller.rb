class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_session
    session[:credentials]
  end
  helper_method :current_session

  def set_current_session(value)
    session[:credentials] = value
  end

private

  def session_required
    unless current_session
      redirect_to root_path, flash: { errors: 'Login required' } and return
    end
  end
end
