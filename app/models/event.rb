class Event < ActiveRecord::Base
  belongs_to :competition
  has_many :event_athletes
  has_many :athletes, :through => :event_athletes
end
