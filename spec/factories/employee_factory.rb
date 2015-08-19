FactoryGirl.define do
  factory :employee do
    fname  'Андрей'
    lname  'Носков'
    sname  'Геннадьевич'
    contact_info  'flashbulb54@gmail.com'
    job_status  'Ищу работу'
    desired_salary  80000
    skills { [FactoryGirl.create(:skill, :ruby), FactoryGirl.create(:skill, :rails)] }
  end
end