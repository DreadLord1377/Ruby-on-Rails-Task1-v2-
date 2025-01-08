class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 1 }
  validates :body, presence: true, length: { minimum: 10 }

  #validation callback
  after_validation :log_errors

  #creation callback
  after_create :log_errors

  #save callback
  before_save do
    throw :abort if title.length > 25
  end

  after_save :log_errors

  #update callback
  after_update :log_errors

  private
    def log_errors
      if errors.any?
        Rails.logger.error("Validation failed: #{errors.full_messages.join(', ')}")
      else
        Rails.logger.info("Successful request")
      end
    end
end
