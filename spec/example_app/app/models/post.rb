class Post < ApplicationRecord
  has_many :post_categories
  has_many :categories, through: :post_categories
  belongs_to :author, class_name: "User"

  validates_presence_of :title, :body

  scope :published, -> { where(published: true) }
  scope :draft, -> { where(published: false) }

  def self.authored_by(username)
    joins(:author).where(users: {username: username})
  end

  def self.search(field, term)
    sanitized_value = sanitize_sql_like(term)
    where("#{field} ILIKE :term", term: "%#{sanitized_value}%")
  end
end
