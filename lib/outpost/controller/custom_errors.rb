module Outpost
  module Controller
    module CustomErrors
      extend ActiveSupport::Concern
      
      NOT_FOUND_ERROR_CLASSES = [
        ActionController::RoutingError, 
        ActionController::UnknownController, 
        AbstractController::ActionNotFound, 
        ActiveRecord::RecordNotFound
      ]

      included do
        rescue_from StandardError, with: ->(e) { render_error(500, e) }
        rescue_from *NOT_FOUND_ERROR_CLASSES, with: ->(e) { render_error(404, e) }
      end
      
      #----------------------
      
      def render_error(status, e=StandardError)
        response.status = status

        if Rails.application.config.consider_all_requests_local
          raise e
        else
          respond_to do |format|
            format.html { render template: "/errors/error_#{status}", status: status, locals: { error: e } }
            format.xml { render xml: { error: response.message, code: status }, status: status }
            format.json { render json: { error: response.message, code: status }, status: status }
            format.text { render text: "#{status} - #{response.message}", status: status}
            format.any { head status }
          end
        end

        return false
      end
    end # CustomErrors
  end
end
