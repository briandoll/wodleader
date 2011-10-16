class Athlete < ActiveRecord::Base
  belongs_to :competition
  has_many :event_athletes, :dependent => :destroy
  validates_presence_of :competition_id
  validates_presence_of :name
  belongs_to :competition_category
  validates_presence_of :competition_category
  
  after_create :create_event_athletes
  
  def category
    competition_category.name
  end
  
  def competition_rank_total
    rank = 0
    event_athletes.each do |ea|
      if ea.event_rank
        event_ranking = (ea.event_rank * ea.event.event_weight)
        rank += event_ranking
      else
        rank += 100
      end
    end
    rank
  end
  
  private
  
  def create_event_athletes
    competition.events.each do |event|
      ea = EventAthlete.new(:athlete_id => self.id, :event_id => event.id)
      ea.save
    end
  end
  
end
