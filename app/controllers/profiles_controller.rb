class ProfilesController < ApplicationController
  def show
    @profiled_user = Profile.username(params[:id])
  end
end
