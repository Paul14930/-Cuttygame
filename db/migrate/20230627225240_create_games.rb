class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.references :winner, foreign_key: { to_table: :profiles }
      t.references :loser, foreign_key: { to_table: :profiles }
      t.timestamps
    end
  end
end
