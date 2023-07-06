class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :username, presence: true, uniqueness: true

  def self.sorted_by_score
    order(score: :desc)
  end

  def update_division
    # Obtenez tous les profils 
    profiles = Profile.all

    # Parcourez chaque profil
    profiles.each do |profile|
      # Obtenez tous les profils du même genre que le profil actuel
      same_gender_profiles = Profile.where(gender: profile.gender)

      # Obtenez les divisions et les scores moyens pour ces profils
      divisions, avg_scores = ProfilesController.get_divisions_and_avg_scores(same_gender_profiles)

      # Trouvez l'index de la division du profil actuel
      current_division_index = divisions.index { |division| division.include?(profile) }

      # Mettez à jour la division du profil
      profile.update_columns(division: current_division_index)
    end
  end
end
