class Employee < ActiveRecord::Base

  JOB_STATUSES = ['Ищу работу', 'Не ищу работу']

  scope :with_vacancies, -> (id) { includes(:ideal_vacancies, :potential_vacancies, :skills)
                                       .references(:ideal_vacancies, :potential_vacancies, :skills)
                                       .find(id)
                                       }

  attr_accessor :fname, :lname, :sname

  has_many :specified_skills, :as => :owner, :dependent => :delete_all
  has_many :skills, :through => :specified_skills

  has_many :total_matches, -> { where(:pct_of_match => 100) },
           :class_name => 'MatchesOfSkill'
  has_many :ideal_vacancies, -> { order(:salary => :desc) },
           :through => :total_matches, :class_name => 'Vacancy', :source => :vacancy

  has_many :partial_matches, -> { where(:pct_of_match => 1..99) },
           :class_name => 'MatchesOfSkill'
  has_many :potential_vacancies, -> { order(:salary => :desc) },
           :through => :partial_matches, :class_name => 'Vacancy', :source => :vacancy

  accepts_nested_attributes_for :skills, :allow_destroy => true

  validates :fname, :lname, :sname, :job_status, :desired_salary, :skills, :presence => true
  validates :job_status, :inclusion => JOB_STATUSES
  validates :fname, :lname, :sname, :name => true
  validates :contact_info, :presence => true, :contact_info => true

  before_save :set_name!

  def last_name
    self.name.split(' ')[0].capitalize
  end

  def first_name
    self.name.split(' ')[1].capitalize
  end

  def surname
    self.name.split(' ')[2].capitalize
  end

  def skills_attributes=(skills)
    self.skills = skills.map { |attrs| Skill.where(attrs).first_or_initialize(attrs)  }
  end

  private

  def set_name!
    self.name = [lname, fname, sname].join(' ')
  end

end
