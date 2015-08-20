module Api

  class ApiController < ActionController::API

    rescue_from ActiveRecord::RecordNotFound,
                :with => -> { render :partial => 'api/v1/layouts/not_found', :status => 404 }

  end

end