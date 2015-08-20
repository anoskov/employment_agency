class Vacancy < ActiveRecord::Base

  scope :with_candidates, -> (id) { includes(:ideal_candidates, :potential_candidates, :skills)
                                        .references(:ideal_candidates, :potential_candidates, :skills)
                                        .find(id) }

  has_many :specified_skills, :as => :owner, :dependent => :delete_all
  has_many :skills, :through => :specified_skills

  has_many :total_matches, -> { where(:pct_of_match => 100) },
           :class_name => 'MatchesOfSkill'
  has_many :ideal_candidates, -> { order(:desired_salary) },
           :through => :total_matches, :class_name => 'Employee', :source => :employee

  has_many :partial_matches, -> { where(:pct_of_match => 1..99) },
           :class_name => 'MatchesOfSkill'
  has_many :potential_candidates, -> { order(:desired_salary) },
           :through => :partial_matches, :class_name => 'Employee', :source => :employee

  accepts_nested_attributes_for :skills, :allow_destroy => true

  validates :title, :expiration_date, :salary, :contact_info, :skills, :presence => true

  # Во время разработки в Postgres версии 9.4 был замечен баг:
    # к правой границе значения типа int4range добавляется единица,
    # поэтому отнимаем ее перед добавлением.
  before_create { self.salary = (self.salary.begin..self.salary.end - 1) }

  def created_date
    self.created_at.strftime('%Y-%m-%d')
  end

end
