# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sheet do
    name { ('a'..'z').to_a.shuffle.first(9).join }
    title "Title"
    text "Text"
    p_id 1

    factory :main_sheet do
      p_id nil
    end
  end
end