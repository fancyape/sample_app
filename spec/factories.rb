FactoryGirl.define do
  factory :user do
    name     "Michael Karch"
    email    "mike1@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end