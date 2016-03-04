class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :resource, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :usability_rating
      t.integer :addictive_rating

      t.timestamps null: false
    end
  end
end
