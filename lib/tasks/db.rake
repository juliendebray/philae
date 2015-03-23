# lib/tasks/db.rake
namespace :db do
  desc "Backs up heroku database and restores it locally. Needs `heroku addons:add pgbackups` first"
  task import_from_heroku: :environment do
    c = Rails.configuration.database_configuration[Rails.env]
    Bundler.with_clean_env do
      `heroku pgbackups:capture --expire`
      `curl -o latest.dump \`heroku pgbackups:url\``
      `pg_restore --verbose --clean --no-acl --no-owner -h localhost -d #{c["database"]} latest.dump`
      `rm latest.dump`
    end
  end
end