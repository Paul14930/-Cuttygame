class RenameProfilsToProfiles < ActiveRecord::Migration[7.0]
  def change
    rename_table :profile, :profiles
  end
end
