class Event < ActiveRecord::Base
  belongs_to :competition
  has_many :event_athletes
  has_many :athletes, :through => :event_athletes
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :competition_id
  
  def ranked_results
    EventAthlete.ranked_and_categorized(self.id)
  end

end
