class MatchingsController < ApplicationController
  #require 'pycall/import'

  def index
    @games = Game.all
  end

  def new
    @sorted_profiles = Profile.sorted_by_score

    divisions = @sorted_profiles.each_slice(6).to_a
    division1 = divisions.sample
    division2 = (divisions - [division1]).sample

    @profile1 = division1.sample
    @profile2 = division2.sample
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
    k_factor = 32

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

#essaie en python avant que je le jette dans chat gpt et qu'il me chie
#un truc en ruby qui fonctione la putain de sa mère
# def update_ratings(winner, loser)
#   score = 1
#   k_factor = 32

#   elo = PyCall.import_module(:elo)
#   winner_new_rating, loser_new_rating = elo.calculate_ratings(winner.score, loser.score, score, k_factor)

#   winner_new_rating = winner_new_rating.round(2)
#   loser_new_rating = loser_new_rating.round(2)

#   winner.update_columns(score: winner_new_rating)
#   loser.update_columns(score: loser_new_rating)
# end
