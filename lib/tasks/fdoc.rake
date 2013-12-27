namespace :fdoc do
  desc "Generate FDOC html"
  task html: :environment do
    `bin/fdoc convert ./docs/fdocs --output=docs/html --url-base-path="/"`
    `open docs/html/index.html`
  end
end