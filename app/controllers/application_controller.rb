class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart
  helper_method :current_user

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_merchant?
    current_user && current_user.merchant?
  end

  def current_default?
    current_user && current_user["role"] == "default"
  end
end
