# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    email "vishnu@test.com"
    password '1234'
    password_confirmation '1234'
  end
end
