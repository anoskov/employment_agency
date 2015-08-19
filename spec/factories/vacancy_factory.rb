FactoryGirl.define do
  factory :vacancy do
    title 'Senior/Ruby on Rails developer'
    expiration_date Date.new(2015, 8, 30)
    contact_info 'e-mail: hr@example.com'
    salary 70000..100000
    skills { [FactoryGirl.create(:skill, :ruby), FactoryGirl.create(:skill, :rails)] }
  end
end