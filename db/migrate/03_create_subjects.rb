class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.belongs_to :category
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
