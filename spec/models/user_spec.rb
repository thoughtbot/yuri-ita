require 'rails_helper'

RSpec.describe User, type: :model do
  describe "username" do
    it "is required" do
      user = User.new

      user.valid?

      expect(user.errors).to be_added(:username, :blank)
    end
  end
end
