class AddRatingsToResources < ActiveRecord::Migration
  def change
    add_column :resources, :usability_ratings, :text, default: "{}"
    add_column :resources, :addictive_ratings, :text, default: "{}"
    add_column :resources, :price_per_month, :decimal
  end
end
