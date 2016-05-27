FactoryGirl.define do
  factory :festivity_event_page do
    title   Faker::Hacker.adjective
    breadcrumb  { title }
    slug        { title.slugify }
    class_name  'FestivityEventPage'
    status_id   100
  end
end