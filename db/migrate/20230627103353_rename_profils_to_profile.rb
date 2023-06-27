class RenameProfilsToProfile < ActiveRecord::Migration[7.0]

    def change
      rename_table :profils, :profile
    end

end
