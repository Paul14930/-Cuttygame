class MatchingsController < ApplicationController
  #require 'pycall/import'

  def index
    @games = Game.all
  end

  def new
    @sorted_profiles = Profile.sorted_by_score

    # Divisez les profils en divisions de taille 6
    divisions = @sorted_profiles.each_slice(6).to_a

    # Calculez le score moyen pour chaque division
    avg_scores = divisions.map { |division| division.sum(&:score) / division.size }

    # Choisissez une division au hasard
    first_division_index = rand(divisions.size)
    @profile1 = divisions[first_division_index].sample

    # Trouvez l'index de la division la plus proche en termes de score moyen, avec une différence de moins de 500
    closest_division_index = avg_scores.each_with_index.min_by { |avg_score, index|
      diff = (avg_score - avg_scores[first_division_index]).abs
      diff < 500 && index != first_division_index ? diff : Float::INFINITY
    }

    if closest_division_index[0] < Float::INFINITY
      @profile2 = divisions[closest_division_index[1]].sample
    else
      # Si aucune division n'a un score moyen à moins de 500 points, choisissez un profil au hasard
      @profile2 = (@sorted_profiles - [@profile1]).sample
    end
  end


  def create
    # On récupère les profils du gagnant et du perdant à partir de leur ID
    winner = Profile.find(params[:winner_id])
    loser = Profile.find(params[:loser_id])

    # Vérifiez si les profils du gagnant et du perdant existent
    if winner && loser
      Rails.logger.info("Winner ID: #{winner.id}")
      Rails.logger.info("Loser ID: #{loser.id}")

      # On met à jour les scores des deux profils en utilisant l'algorithme Elo.
      update_ratings(winner, loser)

      # On redirige ensuite vers l'action 'new' pour choisir les deux prochains profils.
      redirect_to new_matching_path
    else
      # Gérer le cas où les profils du gagnant ou du perdant n'existent pas
      flash[:error] = "Les profils du gagnant ou du perdant sont introuvables."
      redirect_to new_matching_path
    end
  end

  def update_ratings(winner, loser)
    score = 1

    # Définir le K-factor en fonction du score
    k_factor = if winner.score < 2100
                 32
               elsif winner.score.between?(2100, 1900)
                 24
               else
                 16
               end

    # Calculer les nouvelles valeurs de score

    # Calculer l'expectation de victoire pour le gagnant
    expected_winner_score = 1 / (1 + 10**((loser.score - winner.score) / 400.0))
    # Calculer l'expectation de victoire pour le perdant
    expected_loser_score = 1 - expected_winner_score

    # Calculer les nouveaux scores

    # Calculer la variation de score pour le gagnant
    winner_score_change = k_factor * (score - expected_winner_score)
    # Calculer la variation de score pour le perdant
    loser_score_change = k_factor * (0 - expected_loser_score)
    # Calculer les nouveaux scores pour le gagnant et le perdant
    winner_new_rating = winner.score + winner_score_change
    loser_new_rating = loser.score + loser_score_change
    # Arrondir les nouvelles valeurs de score avec 5 décimales
    winner_new_rating = winner_new_rating.round(5)
    loser_new_rating = loser_new_rating.round(5)

    # Mettre à jour les scores des profils dans la base de données

    # Mettre à jour le score du gagnant
    winner.update_columns(score: winner_new_rating)
    # Mettre à jour le score du perdant
    loser.update_columns(score: loser_new_rating)

    # Retourner les nouvelles valeurs de score
    [winner_new_rating, loser_new_rating]
  end

end
