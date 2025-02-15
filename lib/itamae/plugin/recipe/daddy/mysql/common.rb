require 'daddy/itamae'

case os_version
when /rhel-7\.(.*?)/, /rhel-8\.(.*?)/
  template '/etc/yum.repos.d/mysql-community.repo' do
    source ::File.join(::File.dirname(__FILE__), "templates/etc/yum.repos.d/mysql-community.#{os_version.split('.').first}.repo.erb")
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
  end
else
  raise I18n.t('itamae.errors.unsupported_os_version', os_version: os_version)
end

template '/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

execute 'yum clean all' do
  user 'root'
  action :nothing
  subscribes :run, "template[/etc/yum.repos.d/mysql-community.repo]", :immediately
end

case os_version
when /rhel-7\.(.*?)/
  execute 'rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022' do
    user 'root'
    action :nothing
    subscribes :run, "template[/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql]", :immediately
  end
end
