class EventAthlete < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :event
  validates_presence_of :athlete_id
  validates_presence_of :event_id
  
  before_save :result_to_score
  after_save  :update_rankings
  
  def name
    @name ||= "#{competition.name} / #{athlete.name} / #{event.name}"
  end
  
  def athlete_number
    @athlete_number ||= athlete.number
  end
  
  def competition
    @competition ||= event.competition.name
  end
  
  private
  
  def result_to_score
    self.score = result
  end

  def self.sort_scores(scores, lowest_wins = true)
    no_score, scored = scores.partition{|e| e.nil? }
    if lowest_wins
      (scored.sort + no_score)
    else
      (scored.sort.reverse + no_score)
    end
  end

  def soft_sort_by_rankings
    event = self.event
    lower_wins = event.rank_by_small
    unranked = event.event_athletes
    EventAthlete.sort_scores unranked, lower_wins
  end
  
  def update_rankings
    # yea... so this just causes an infinite loop
    # because when we save, we update the rankings
    # which saves each item, which updates rankings
    # which...
    #soft_sort_by_rankings.each_with_index do |ea, index|
      #ea.event_rank = (index + 1) #index is zero based
      #ea.save
    #end
  end
  
end
