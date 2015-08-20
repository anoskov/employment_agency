FactoryGirl.define do
  factory :vacancy do
    title 'Senior/Ruby on Rails developer'
    expiration_date Date.new(2015, 8, 30)
    contact_info 'e-mail: hr@example.com'
    salary 70000..100000
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