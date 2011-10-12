class AddWeightingForEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_weight, :decimal, :default => 1.0
  end
end
