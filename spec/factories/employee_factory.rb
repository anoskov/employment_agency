FactoryGirl.define do
  factory :employee do
    fname  'Андрей'
    lname  'Носков'
    sname  'Геннадьевич'
    contact_info  'flashbulb54@gmail.com'
    job_status  'Ищу работу'
    desired_salary  80000
    skills { [FactoryGirl.create(:skill, :title => 'Ruby'), FactoryGirl.create(:skill, :title => 'Rails')] }

    trait :with_all_skills do
      skills {[
                FactoryGirl.create(:skill, :title => 'Ruby'),
                FactoryGirl.create(:skill, :title => 'Rails'),
                FactoryGirl.create(:skill, :title => 'PostgreSQL')
      ]}
    end
  end
end