class CreateEventAthletes < ActiveRecord::Migration
  def change
    create_table :event_athletes do |t|
      t.integer :athlete_id
      t.integer :event_id
      t.string  :result
      t.integer :score
      t.integer :event_rank
      t.timestamps
    end
  end
end
