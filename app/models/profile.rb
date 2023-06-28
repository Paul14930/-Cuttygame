class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :username, presence: true, uniqueness: true

  def self.sorted_by_score
    order(score: :desc)
  end
end
