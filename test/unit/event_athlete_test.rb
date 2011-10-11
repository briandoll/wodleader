require 'test_helper'

class EventAthleteTest < ActiveSupport::TestCase

  def test_result_to_score_for_integer
    ea = EventAthlete.first
    ea.result = '100'
    ea.save
    
    assert_equal 100, ea.score
  end
  
  def test_result_to_score_for_float
    ea = EventAthlete.first
    ea.result = '100.3'
    ea.save
    
    assert_equal 100.3, ea.score
  end
  
  def test_result_to_score_for_duration
    ea = EventAthlete.first
    ea.result = '1:11:16'
    ea.save
    
    assert_equal 71.2666666666667, EventAthlete.first.score
  end
  
  def test_sort_with_nils
    start  = [2, 4, 3, 6, nil, 9, nil]
    lower  = [2, 3, 4, 6, 9, nil, nil]
    higher = [9, 6, 4, 3, 2, nil, nil]

    #assert_equal lower, EventAthlete.sort_scores(start, true)
    #assert_equal higher,EventAthlete.sort_scores(start, false)
  end
  
  def test_event_sorting_by_fastest
    event = Event.first
    event.rank_by_small = true
    event.save
    
    fourth, third, second, first = event.event_athletes
    first.result = '100'
    first.save
    second.result = '200'
    second.save
    third.result = '201'
    third.save
    fourth.result = '203'
    fourth.save
    
    assert_equal 1, EventAthlete.find(first.id).event_rank
    assert_equal 2, EventAthlete.find(second.id).event_rank
    assert_equal 3, EventAthlete.find(third.id).event_rank
    assert_equal 4, EventAthlete.find(fourth.id).event_rank
  end
  
  def test_that_tie_scores_get_correct_rankings
    event = Event.first
    event.rank_by_small = true
    event.save
    
    fourth, third, second, first = event.event_athletes
    first.result = '100'
    first.save
    second.result = '200'
    second.save
    third.result = '200'
    third.save
    fourth.result = '300'
    fourth.save

    assert_equal 1, EventAthlete.find(first.id).event_rank
    assert_equal 2, EventAthlete.find(second.id).event_rank
    assert_equal 2, EventAthlete.find(third.id).event_rank
    assert_equal 4, EventAthlete.find(fourth.id).event_rank
  end
  
end
