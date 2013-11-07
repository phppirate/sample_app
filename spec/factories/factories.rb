FactoryGirl.define do
  factory :user do
    name                  "Sam Podlogar"
    email                 "sam@podlogar.com"
    password              "testing"
    password_confirmation "testing"
  end
end