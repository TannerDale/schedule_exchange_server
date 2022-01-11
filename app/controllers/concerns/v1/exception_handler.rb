module V1::ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: {
        message: 'Your query could not be completed',
        error: { details: e.message }
      }, status: :not_found
    end

    rescue_from ActionController::BadRequest, ActiveRecord::RecordInvalid do |e|
      render json: {
        message: 'Invalid query',
        error: { details: e.message }
      }, status: :bad_request
    end
  end
end
