class Competition < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :athletes, :dependent => :destroy
  validates_presence_of :name, :when, :where

  def leader_board
    leaders = {}
    athletes.each do |athlete|
      if leaders[athlete.category]
        leaders[athlete.category] << athlete
      else
        leaders[athlete.category] = [athlete]
      end
    end
    
    leaders.each do |category, athletes|
      leaders[category] = athletes.sort{|a,b| a.competition_rank_total <=> b.competition_rank_total}
    end
    leaders
  end
  
  def most_recent_stat_update
    event_ids = events.select{|event| event.id}
    recent = EventAthlete.where(:event_id => event_ids).order('updated_at DESC').first
    puts recent.inspect
    if recent
      recent.updated_at
    else
      nil
    end
  end
  
  def to_param
    "#{id}-#{name.downcase.gsub(/[^a-z0-9]+/,'-').gsub(/-+&$/, '').gsub(/^-+$/, '')}"
  end

end
