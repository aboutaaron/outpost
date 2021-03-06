FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    body "Lorem, etc."
  end

  factory :person do
    name "Marty McFly"
    email "backin@time.com"
    location "Hill Valley, California"
    age 17
  end

  factory :pidgeon do
    name "Doc Brown"
    location "Everywhere"
  end

  factory :user do
    name "Jackie Brown"
    sequence(:email) { |n| "jbrown#{n}@qt.com" }
    can_login true
    is_superuser false
    password "secret"
  end

  factory :permission do
    resource "Post"
  end
end
