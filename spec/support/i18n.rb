RSpec.configure do |config|
  config.include ActionView::Helpers::TranslationHelper
end

I18n.exception_handler = lambda do |exception, locale, key, options|
  puts exception
  raise "missing translation: #{key}"
end