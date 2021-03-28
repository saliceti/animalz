FactoryBot.define do

    factory :youtube_video do
      BASE_LINK = 'https://youtu.be/V06FJGSQ3U'
      sequence(:link) { |n| "#{BASE_LINK}#{n}" }
      association :animon
    end

  end
