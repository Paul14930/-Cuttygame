class DivisionMatchesController < ApplicationController
  def index
    # Prenez le genre opposé du profil actuel
    opposite_gender = current_user.profile.gender == 'Homme' ? 'Femme' : 'Homme'

    # Prenez la division du profil actuel
    current_division = current_user.profile.division

    # Filtrer les profils par genre opposé et par division
    @matches = Profile.where(gender: opposite_gender, division: current_division).sorted_by_score
  end
end
