class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  if Rails.env.production?
    http_basic_authenticate_with(
      name: Rails.application.credentials[:basic_auth_user],
      password: Rails.application.credentials[:basic_auth_password]
    )
  end
end
