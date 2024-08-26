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


  def set_current_user
    @current_user=User.find_by(id :session[:user_id])
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
  end
end