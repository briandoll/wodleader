require 'test_helper'

class AthleteTest < ActiveSupport::TestCase

  def test_create_athlete_also_creates_event_athletes
    competition = Competition.new(:name => 'example event')
    competition.save
    event1 = Event.new(:name => 'go heavy', :competition_id => competition.id)
    event1.save
    event2 = Event.new(:name => 'go fast',  :competition_id => competition.id)
    event2.save
    athlete = Athlete.new(:name => 'brian', :competition_id => competition.id)
    athlete.save
    
    assert_not_nil EventAthlete.where(:athlete_id => athlete.id, :event_id => event1.id).first
    assert_not_nil EventAthlete.where(:athlete_id => athlete.id, :event_id => event2.id).first
  end

end
