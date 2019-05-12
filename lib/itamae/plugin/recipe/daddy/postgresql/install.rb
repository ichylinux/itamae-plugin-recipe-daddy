require 'daddy/itamae'

case os_version
when /rhel-7\.(.*?)/
  %w{
    postgresql-devel
    postgresql-server
  }.each do |name|
    package name do
      user 'root'
    end
  end

  execute 'postgresql-setup initdb && touch /var/lib/pgsql/data/INITIALIZED' do
    user 'root'
    not_if 'test -e /var/lib/pgsql/data/INITIALIZED'
  end

else
  raise "unsupported os version #{os_version}"
end

service 'postgresql' do
  user 'root'
  action [:enable]
end

template '/var/lib/pgsql/data/pg_hba.conf' do
  user 'root'
  owner 'postgres'
  group 'postgres'
  mode '600'
end

service 'postgresql' do
  user 'root'
  subscribes :restart, 'template[/var/lib/pgsql/data/pg_hba.conf]'
  action :nothing
end
