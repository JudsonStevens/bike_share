FactoryBot.define do
  factory :item do
    sequence(:title) { |n| "Title #{n}"}
    sequence(:price) { |n| n.to_i}
    sequence(:description) { |n| " Description#{n}"}
    sequence(:image) { |n| "Image #{n}"}
  end
end
