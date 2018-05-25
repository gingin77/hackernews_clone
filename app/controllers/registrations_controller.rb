class RegistrationsController < Devise::RegistrationsController

  protected

  def after_inactive_sign_up_path_for(resource)
    users_path
  end

  def update_resource(user, params)
    user.update_without_password(params)
  end

  def after_update_path_for(user)
    user_path(user.name)
  end
end
