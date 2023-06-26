class CreateProfils < ActiveRecord::Migration[7.0]
  def change
    create_table :profils do |t|
      t.string :username
      t.date :date_birth
      t.string :gender
      t.string :location
      t.string :orientation
      t.text :description

      t.timestamps
    end
  end
end
