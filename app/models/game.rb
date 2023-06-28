class Game < ApplicationRecord
  belongs_to :winner, class_name: 'Profile'
  belongs_to :loser, class_name: 'Profile'
end
