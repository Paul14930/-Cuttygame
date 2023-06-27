class AddScoreToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :score, :float
  end
end
