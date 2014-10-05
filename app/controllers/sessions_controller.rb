class SessionsController < ApplicationController
  def new
  end

  def create
    authentication = Authentication.new(session_params)

    if authentication.perform.success?
      redirect_to report_path
    else
      redirect_to new_session_path, flash: { errors: authentication.errors.to_s }
    end
  end

  def destroy
    Authentication.deauthenticate
    redirect_to root_path
  end

private

  def session_params
    params.permit(:email, :password)
  end
end
