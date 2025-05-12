require 'daddy/itamae'

case os_version
when /rhel-7\.(.*?)/
  template '/etc/yum.repos.d/mysql-community.repo' do
    source ::File.join(::File.dirname(__FILE__), "templates/etc/yum.repos.d/mysql-community.rhel-7.repo.erb")
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
  end

  execute 'rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022' do
    user 'root'
    action :nothing
    subscribes :run, "template[/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql]", :immediately
  end
when /rhel-8\.(.*?)/
  template '/etc/yum.repos.d/mysql-community.repo' do
    source ::File.join(::File.dirname(__FILE__), "templates/etc/yum.repos.d/mysql-community.rhel-8.repo.erb")
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
  end

  execute 'dnf -y module disable mysql' do
    user 'root'
    action :nothing
    subscribes :run, "template[/etc/yum.repos.d/mysql-community.repo]", :immediately
  end

  execute 'rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023' do
    user 'root'
    action :nothing
    subscribes :run, "template[/etc/yum.repos.d/mysql-community.repo]", :immediately
  end
else
  raise I18n.t('itamae.errors.unsupported_os_version', os_version: os_version)
end

execute 'yum clean all' do
  user 'root'
  action :nothing
  subscribes :run, "template[/etc/yum.repos.d/mysql-community.repo]", :immediately
end
