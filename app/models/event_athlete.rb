class EventAthlete < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :event
  validates_presence_of :athlete_id
  validates_presence_of :event_id
  
  def name
    "#{event.competition.name} / #{athlete.name} / #{event.name}"
  end
  
  def athlete_number
    athlete.number
  end
  
  def competition
    event.competition.name
  end
end
