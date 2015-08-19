class Employee < ActiveRecord::Base

  JOB_STATUSES = ['Ищу работу', 'Не ищу работу', 'Открыт к предложениям']

  attr_accessor :fname, :lname, :sname

  has_many :specified_skills, :as => :owner, :dependent => :delete_all
  has_many :skills, :through => :specified_skills

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

  private

  def set_name!
    self.name = [lname, fname, sname].join(' ')
  end

end
