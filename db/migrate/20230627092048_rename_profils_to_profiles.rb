class RenameProfilsToProfiles < ActiveRecord::Migration[7.0]
  def change
    rename_table :profils, :profiles
  end
end
