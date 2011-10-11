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

  def self.sort_scores(event_athletes, lowest_wins = true)
    no_score, scored = event_athletes.partition{|e| e.score.nil? }
    sorted_by_score = scored.sort{|a,b| a.score <=> b.score}
    if lowest_wins
      (sorted_by_score + no_score)
    else
      (sorted_by_score.reverse + no_score)
    end
  end

  def soft_sort_by_rankings
    event = self.event
    lower_wins = event.rank_by_small
    unranked = event.event_athletes
    EventAthlete.sort_scores unranked, lower_wins
  end
  
  def update_rankings
    if self.result_changed?
      previous_score_value = nil
      previous_rank = nil

      soft_sort_by_rankings.each_with_index do |ea, index|
        if ea.score.eql?(previous_score_value)
          ea.event_rank = previous_rank
        else
          ea.event_rank = (index + 1) #index is zero based
        end
        ea.save
        
        previous_score_value = ea.score
        previous_rank = ea.event_rank
      end
    end
  end
  
end
