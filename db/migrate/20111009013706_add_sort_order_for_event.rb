class AddSortOrderForEvent < ActiveRecord::Migration
  def change
    add_column :events, :rank_by_small, :boolean
  end
end
