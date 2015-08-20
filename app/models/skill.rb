class Skill < ActiveRecord::Base

  has_many :specified_skills, :dependent => :delete_all

  validates :title, :presence => true, :uniqueness => true

end
