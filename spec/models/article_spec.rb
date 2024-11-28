require "rails_helper"
require "spec_helper"

RSpec.describe Article, type: :model do
	it "is valid with valid attributes" do
		expect(Article.new).to be_valid
	end
end