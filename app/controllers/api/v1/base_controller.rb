module Api
  module V1

    class BaseController < ApiController

      rescue_from ActiveRecord::RecordNotFound,
                  :with => -> { render :partial => 'api/v1/layouts/not_found', :status => 404 }

    end

  end
end