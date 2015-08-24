class MatchesOfSkill < ActiveRecord::Base

  belongs_to :employee
  belongs_to :vacancy

  scope :total_matches, -> { where(:pct_of_match => 100, :worthy_salary => true) }
  scope :partial_matches, -> { where('pct_of_match between 1 and 99 or worthy_salary = false') }

  after_initialize :readonly!

end
