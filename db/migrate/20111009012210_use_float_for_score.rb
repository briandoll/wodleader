class UseFloatForScore < ActiveRecord::Migration
  def change
    change_column :event_athletes, :score, :float
  end
end