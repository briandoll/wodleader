class RelateAthletesToCompetition < ActiveRecord::Migration
  def up
    add_column :athletes, :competition_id, :integer
  end

  def down
    remove_column :athletes, :competition_id, :integer
  end
end