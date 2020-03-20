class Movie < ApplicationRecord

  module Status
    RUMORED = "Rumored".freeze
    POST_PRODUCTION = "Post Production".freeze
    RELEASED = "Released".freeze
    CANCELLED = "Cancelled".freeze
  end

  scope :rumored, -> { where(status: Status::RUMORED) }
  scope :post_production, -> { where(status: Status::POST_PRODUCTION) }
  scope :released, -> { where(status: Status::RELEASED) }
  scope :cancelled, -> { where(status: Status::CANCELLED) }

  def self.search(field, term)
    sanitized_value = sanitize_sql_like(term)
    where("#{field} ILIKE :term", term: "%#{sanitized_value}%")
  end
end
