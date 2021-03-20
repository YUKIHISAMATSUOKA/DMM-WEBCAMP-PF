class OmniauthCallbacksController < ApplicationController

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    @omniauth = request.env['omniauth.auth']
    info = Customer.find_oauth(@omniauth)
    @customer = info[:customer]
    if @customer.persisted?
      sign_in_and_redirect @customer, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      @sns = info[:sns]
      render template: "devise/registrations/new"
    end
  end

  def failure
    redirect_to root_path and return
  end

end
