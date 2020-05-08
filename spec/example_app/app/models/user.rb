class User < ApplicationRecord
  validates :username, presence: true
end
