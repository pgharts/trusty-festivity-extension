FactoryGirl.define do
  factory :site do
    name  Faker::Hacker.noun
    domain  Faker::Internet.domain_name
    homepage_id 3
    base_domain { domain }
    position 3
  end
end