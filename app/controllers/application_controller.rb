class ApplicationController < ActionController::Base
  include Pundit::Authorization

  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def require_login
    redirect_to root_path, status: :see_other unless user_signed_in?
  end

  def user_not_authorized
    redirect_to root_path, alert: t("errors.not_authorized")
  end
end
