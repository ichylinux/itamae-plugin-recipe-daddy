include_recipe 'daddy::mysql::common'

case os_version
when /rhel-7\.(.*?)/, /rhel-8\.(.*?)/
  package 'mysql-community-client' do
    user 'root'
  end

  package 'mysql-community-devel' do
    user 'root'
  end
else
  raise I18n.t('itamae.errors.unsupported_os_version', os_version: os_version)
end
