class Skill < ActiveRecord::Base

  has_many :specified_skills, :dependent => :delete_all
  has_many :vacancies, :through => :specified_skills
  has_many :employees, :through => :specified_skills

  validates :title, :presence => true, :uniqueness => true

end
