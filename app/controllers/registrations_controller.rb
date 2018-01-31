class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(user, params)
    resource.update_without_password(params)
  end
end
