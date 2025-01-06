class Comment < ApplicationRecord
  include Visible

  belongs_to :article

  validates :commenter, presence: true, length: { minimum: 1 }
  validates :body, presence: true, length: { minimum: 1 }

  #validation callback
  after_validation :log_errors

  #creation callback
  after_create :log_errors

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