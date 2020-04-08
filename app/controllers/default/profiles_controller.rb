class Default::ProfilesController < Default::BaseController
  before_action :require_default

  def show
  end

  private
    def require_default
      render file: "/public/404" unless current_default?
    end
end
