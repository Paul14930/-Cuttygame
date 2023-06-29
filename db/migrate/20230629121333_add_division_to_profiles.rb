class AddDivisionToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :division, :string
  end
end
