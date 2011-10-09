class Competition < ActiveRecord::Base
  has_many :events
  has_many :athletes
  validates_presence_of :name, :when, :where
end
