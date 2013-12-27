require 'fileutils'

namespace :fdoc do
  desc "Generate FDOC html"
  task html: :environment do
    puts "----- Clearing old API docs..."
    `rm -rf docs/html`
    puts "----- Generating new API docs..."
    `bin/fdoc convert ./docs/fdocs --output=docs/html --url-base-path='/'`
    puts "----- Docs generated! To view, run 'open docs/html/index.html'"
  end

  desc "Publish the docs to the GithubPages repo"
  task publish: :html do
    cd = "cd ../gripthumb.github.io"
    puts "----- Copying html/ to pages repo"
    `cp -rf docs/html/* ../gripthumb.github.io`

    puts "----- Committing and pushing pages repo"
    `#{cd} && git add . && git commit -am 'Published FDocs @ #{Date.today}'`
    puts "----- Pushing to Github"
    `#{cd} && git push origin master`
    puts "----- Docs published to 'http://docs.gripthumb.com'"
  end
end