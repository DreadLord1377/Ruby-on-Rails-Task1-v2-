class ApplicationController < ActionController::API
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  #allow_browser versions: :modern
  
  include Pagination

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  rescue_from JSON::ParserError do |exception|
    render json: { errors: exception.record.errors }, status: :not_found
  end

  def not_found
    head 404
  end
end
