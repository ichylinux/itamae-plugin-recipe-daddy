version = ENV['REDMINE_VERSION'] || ItamaePluginRecipeDaddy::REDMINE_VERSION

include_recipe 'daddy::postgresql'
include_recipe 'daddy::redmine::install'

local_ruby_block 'setup redmine database' do
  block do
    at_exit do
      Itamae.logger.info "Run following commands to proceed.\n" + <<-EOF

--------------------------------------------------------------------------------

sudo -s
cd /var/lib/pgsql
sudo -u postgres createuser -P redmine
sudo -u postgres createdb -E UTF-8 -l ja_JP.UTF-8 -O redmine -T template0 redmine
exit
cd /opt/redmine/redmine-#{version}
sudo vi /opt/redmine/redmine-#{version}/config/database.yml
sudo vi /opt/redmine/redmine-#{version}/config/configuration.yml
sudo -u redmine bundle exec rake generate_secret_token
sudo -u redmine bundle exec rake db:migrate RAILS_ENV=production

--------------------------------------------------------------------------------
      EOF
    end
  end
end
