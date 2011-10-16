class EventAthlete < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :event
  validates_presence_of :athlete_id
  validates_presence_of :event_id
  
  before_save :result_to_score
  after_save  :update_rankings
  
  def name
    @name ||= "#{competition} / #{athlete.name} / #{event.name}"
  end
  
  def athlete_number
    @athlete_number ||= athlete.number
  end
  
  def competition
    @competition ||= event.competition.name
  end
  
  def self.ranked(event_id)
    close = EventAthlete.find_all_by_event_id(event_id, :order => :event_rank)
    no_rank, ranked = close.partition{|ea| ea.event_rank.nil? }
    (ranked + no_rank)
  end
  
  def self.ranked_and_categorized(event_id)
    EventAthlete.event_athletes_by_category(EventAthlete.ranked(event_id))
  end
  
  private
  
  def result_to_score
    score = result
    if result.to_s.split(":").size > 1
      score = EventAthlete.time_to_seconds(result)
    end
    self.score = score
  end

  def self.time_to_seconds(time_str)
    seconds = nil 
    split_str = time_str.to_s.split(":")
    if split_str.size == 3
      seconds =  (split_str[0].to_f * 60) + (split_str[1].to_f) + (split_str[2].to_f / 60)
    elsif split_str.size == 2
      seconds = (split_str[0].to_f) + (split_str[1].to_f / 60)
    end
    seconds
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

  def soft_sort_by_rankings(unsorted_grouping)
    event = self.event
    lower_wins = event.rank_by_small
    EventAthlete.sort_scores unsorted_grouping, lower_wins
  end
  
  def self.event_athletes_by_category(event_athletes)
    categorized = {}
    event_athletes.each do |event_athlete|
      category = event_athlete.athlete.category
      if categorized[category]
        categorized[category] << event_athlete
      else
        categorized[category] = [event_athlete]
      end
    end
    categorized
  end
  
  def update_rankings
    if self.result_changed?
      event_athletes = event.event_athletes
      lower_wins = event.rank_by_small
      rankings = EventAthlete.event_athletes_by_category(event_athletes)
      rankings.each do |category,ea|
        update_ranked_group(EventAthlete.sort_scores(ea, lower_wins))
      end
      
    end
  end

  def update_ranked_group(sorted_grouping)
    previous_score_value = nil
    previous_rank = nil

    sorted_grouping.each_with_index do |ea, index|
      if same_scores(ea.score, previous_score_value)
        ea.event_rank = previous_rank
      else
        ea.event_rank = (index + 1) #index is zero based
      end
      ea.save
      
      previous_score_value = ea.score
      previous_rank = ea.event_rank
    end
    
  end

  
  def same_scores(score_a, score_b)
    if score_a.is_a?(Float) && score_b.is_a?(Float)
      score_a.round_to(12).eql?(score_b.round_to(12))
    else
      score_a.eql?(score_b)
    end
  end
  
end
