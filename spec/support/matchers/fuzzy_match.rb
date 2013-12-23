RSpec::Matchers.define :fuzzy_match do |compared|
  match do |string|
    string.match(%r{#{compared}}i).present?
  end
end