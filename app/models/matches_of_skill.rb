class MatchesOfSkill < ActiveRecord::Base

  belongs_to :employee
  belongs_to :vacancy

  after_initialize :readonly!

end
