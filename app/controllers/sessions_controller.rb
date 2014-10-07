class SessionsController < ApplicationController
  def new
    redirect_to report_path if current_session
  end

  def create
    authentication = Authentication.new(session_params)

    if authentication.perform.success?
      set_current_session authentication.access_cookies
      redirect_to report_path
    else
      redirect_to new_session_path, flash: { errors: authentication.errors.to_s }
    end
  end

  def destroy
    set_current_session nil
    redirect_to root_path
  end

private

  def session_params
    params.permit(:email, :password)
  end
end
