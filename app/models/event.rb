class Event < ActiveRecord::Base
  belongs_to :competition
  has_many :event_athletes, :dependent => :destroy
  has_many :athletes, :through => :event_athletes
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :competition_id
  
  after_create :create_event_athletes
  
  def ranked_results
    EventAthlete.ranked_and_categorized(self.id)
  end

  def <=>(other)
    name <=> other.name
  end

  private
  
  def create_event_athletes
    competition.athletes.each do |athlete|
      ea = EventAthlete.find_by_athlete_id_and_event_id(athlete.id, self.id)
      if !ea
        ea = EventAthlete.new(:athlete_id => athlete.id, :event_id => self.id)
        ea.save
      end
    end
  end

end
