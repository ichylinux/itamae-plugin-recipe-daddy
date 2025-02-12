require 'daddy/itamae'

case os_version
when /rhel-7\.(.*?)/
  template '/etc/yum.repos.d/mysql-community.repo' do
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
    variables enable_57: 1,
              enable_80: 0
  end
when /rhel-8\.(.*?)/
  template '/etc/yum.repos.d/mysql-community.repo' do
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
    variables enable_57: 0,
              enable_80: 1
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

execute 'yum clean all' do
  user 'root'
  action :nothing
  subscribes :run, "template[/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql]", :immediately
end
