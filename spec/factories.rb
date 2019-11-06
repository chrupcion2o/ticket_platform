FactoryBot.define do
  factory :event do
    name { 'Music festival' }
    date { '2019-11-26 15:01:56 UTC' }
    info { 'Detailed event info' }
  end

  factory :ticket do
    qunantity { 200 }
    ticket_type { 'even' }
    price { 20.0 }
    currency { 'EUR' }
    event_id { 1 }

    trait :all_together do
      ticket_type { 'all_together' }
    end
  end
end
