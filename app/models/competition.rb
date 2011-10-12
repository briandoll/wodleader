class Competition < ActiveRecord::Base
  has_many :events
  has_many :athletes
  validates_presence_of :name, :when, :where

  def leader_board
    athletes.sort{|a,b| a.competition_rank_total <=> b.competition_rank_total}
  end
  
  def to_param
    "#{id}-#{name.downcase.gsub(/[^a-z0-9]+/,'-').gsub(/-+&$/, '').gsub(/^-+$/, '')}"
  end

end
