module Pagination
  extend ActiveSupport::Concern

  def default_records_per_page
    10
  end

  def page_index
    params[:page]&.to_i || 1
  end

  def records_per_page
    params[:per_page]&.to_i || default_records_per_page
  end

  def paginate_offset
    (page_index - 1) * records_per_page
  end

  def paginate
    ->(it) { it.limit(records_per_page).offset(paginate_offset) }
  end
end