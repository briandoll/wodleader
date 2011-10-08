class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :competition_id
      t.text :description
      t.timestamps
    end
  end
end
