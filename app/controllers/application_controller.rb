class ApplicationController < ActionController::Base
before_action :authenticate_admin!, if: :admin_url

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_groups_path
    when User
      root_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when Admin
      root_path
    when User
      root_path
    else
      root_path
    end
  end

  def admin_url
    request.fullpath.include?("/admin")
  end

end