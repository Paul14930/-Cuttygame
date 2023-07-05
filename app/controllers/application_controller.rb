class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  def after_sign_up_path_for(resource)
    new_profile_path
    raise
  end
  def default_url_options
    { host: ENV["https://www.cutygame.com"] || "localhost:3000" }
  end
end
