FactoryGirl.define do
  sequence(:name) {|n| "name #{n}" }
  factory :part do
    name

    factory :part_with_song do
      song
    end
  end

  factory :song do
    sequence(:guid) {|n| n.to_s}

    artist_name { "Artist" }
    name
  end
end
