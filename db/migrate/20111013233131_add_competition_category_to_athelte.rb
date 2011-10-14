class AddCompetitionCategoryToAthelte < ActiveRecord::Migration
  def change
    add_column :athletes, :competition_category_id, :integer
  end
end
