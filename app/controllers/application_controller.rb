class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  def after_sign_up_path_for(resource)
    new_profile_path
    raise
  end
end
