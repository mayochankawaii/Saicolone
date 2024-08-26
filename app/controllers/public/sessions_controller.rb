class Public::SessionsController < Devise::SessionsController
  before_action :reject_user, only: [:create]

  protected

  def reject_user
    @user = @user.find_by(email: params[:user][:email].downcase)
    if @user
      if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false))

      flash[:alert] = "退会済みです。再度ご登録をしてご利用ください"
      redirect_to new_@user_registration_path
      end
      flash[:alert] = "必須項目を入力してください"
    end
  end

  def reject_user
     devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

end