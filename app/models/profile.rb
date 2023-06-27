class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  def self.sorted_by_score
    order(score: :desc)
  end
end
