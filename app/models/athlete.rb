class Athlete < ActiveRecord::Base
  belongs_to :competition
  has_many :event_athletes
end
