class AddScoreToProfils < ActiveRecord::Migration[7.0]
  def change
    add_column :profils, :score, :float
  end
end
