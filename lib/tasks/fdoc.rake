namespace :fdoc do
  desc "Generate FDOC html"
  task html: :environment do
    `bin/fdoc convert ./docs/fdocs --output docs/html`
  end
end