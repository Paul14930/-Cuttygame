class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]


  def index
    @profiles = Profile.all
    @sorted_profiles = Profile.sorted_by_score
  end

  def show
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save!
      redirect_to @profile, notice: "Profile was successfully created."
    else
      render :new
    end
  end

  def edit
  end



  def destroy
    @profile.destroy
    redirect_to profiles_url, notice: "Profile was successfully destroyed."
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def update
    if @profile.update(profile_params)
      update_score(@profile)
      redirect_to @profile, notice: "Profile was successfully updated."
    else
      render :edit
    end
  end

  def update_score(profile)

    games = Game.where("winner_id = ? OR loser_id = ?", profile.id, profile.id)
    score = games.where(winner_id: profile.id).count - games.where(loser_id: profile.id).count

    profile.update_columns(score: score)
  end

  def profile_params
    params.require(:profile).permit(:username, :date_birth, :gender, :location, :orientation, :description, :user_id, :score, :title, :body, :photo)
  end

  def self.get_divisions_and_avg_scores(profiles)
    # Exclure les profils avec un score nul
    non_null_profiles = profiles.reject { |profile| profile.score.nil? }

    # Trier les profils par score croissant
    sorted_profiles = non_null_profiles.sort_by(&:score)

    # Calculer le nombre de profils par division
    profiles_per_division = (sorted_profiles.size / 6.0).ceil

    # Divisez les profils en divisions
    divisions = sorted_profiles.each_slice(profiles_per_division).to_a

    # Calculez le score moyen pour chaque division
    avg_scores = divisions.map do |division|
      division_size = division.size.to_f
      division_size.zero? ? 0 : division.sum(&:score) / division_size
    end

    return divisions, avg_scores
  end
end
