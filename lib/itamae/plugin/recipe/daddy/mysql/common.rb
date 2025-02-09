require 'daddy/itamae'

case os_version
when /rhel-7\.(.*?)/
  template '/etc/yum.repos.d/mysql-community.repo' do
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
  end

  template '/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql' do
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
  end

  execute 'yum clean all --enablerepo=mysql57-community' do
    user 'root'
    action :nothing
    subscribes :run, "template[/etc/yum.repos.d/mysql-community.repo]", :immediately
  end
else
  raise I18n.t('itamae.errors.unsupported_os_version', os_version: os_version)
end
