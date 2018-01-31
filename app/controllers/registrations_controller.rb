class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(user, params)
    user.update_without_password(params)
  end

  def after_update_path_for(user)
    profile_path(user.name)
  end
end
