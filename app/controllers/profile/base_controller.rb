class Profile::BaseController < ApplicationController
  before_action :require_default

  private
    def require_default
      render file: "/public/404" unless current_default?
    end
end
