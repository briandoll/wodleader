class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.string  :number
      t.string  :name
      t.integer :age
      t.string  :affiliation
      t.timestamps
    end
  end
end
