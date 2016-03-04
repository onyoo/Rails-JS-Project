class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :url
      t.string :description
      t.belongs_to :subject
      t.belongs_to :user
      t.decimal :price_per_month

      t.timestamps null: false
    end
  end
end
