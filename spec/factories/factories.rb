FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}"}
    sequence(:email) { |n| "Person_#{n}@example.com"}
    password              "testing"
    password_confirmation "testing"
  end

  factory :admin do
    admin true
  end
end