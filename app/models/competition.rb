class Competition < ActiveRecord::Base
  has_many :events
  validates_presence_of :name, :when, :where
end
