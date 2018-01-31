class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(user, params)
    user.update_without_password(params)
  end
end
