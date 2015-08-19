class Vacancy < ActiveRecord::Base

  has_many :specified_skills, :as => :owner, :dependent => :delete_all
  has_many :skills, :through => :specified_skills

  accepts_nested_attributes_for :skills, :allow_destroy => true

  validates :title, :expiration_date, :salary, :contact_info, :skills, :presence => true

  # Во время разработки в Postgres версии 9.4 был замечен баг:
    # к правой границе значения типа int4range добавляется единица,
    # поэтому отнимаем ее перед добавлением.
  before_create { self.salary = (self.salary.begin..self.salary.end - 1) }

end
