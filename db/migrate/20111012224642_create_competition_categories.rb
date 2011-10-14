class CreateCompetitionCategories < ActiveRecord::Migration
  def change
    create_table :competition_categories do |t|
      t.string :name
      t.timestamps
    end
  end
end
