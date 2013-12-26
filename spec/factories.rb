FactoryGirl.define do
  sequence(:name) {|n| "name #{n}" }
  factory :part do
    name
    video
    factory :part_with_song do
      song
    end
  end

  factory :song do
    sequence(:guid) {|n| n.to_s}

    name
    artist_name { "Artist" }
  end

  factory :video do
    name
  end
end
