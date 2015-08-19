FactoryGirl.define do
  factory :skill do

    title "default"

    trait :ruby do
      title "Ruby"
    end

    trait :rails do
      title "Rails"
    end

  end
end