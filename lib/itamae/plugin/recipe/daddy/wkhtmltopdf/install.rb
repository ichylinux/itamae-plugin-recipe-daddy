require 'daddy/itamae'

version = ENV['WKHTMLTOPDF_VERSION'] || ItamaePluginRecipeDaddy::WKHTMLTOPDF_VERSION

directory '/var/daddy/tmp' do
  user 'root'
end

case os_version
when /rhel-7\.(.*?)/
  execute "download wkhtmltox-#{version}" do
    cwd '/var/daddy/tmp'
    command <<-EOF
      rm -f wkhtmltox-#{version}.centos7.x86_64.rpm
      wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/#{version.split('-').first}/wkhtmltox-#{version}.centos7.x86_64.rpm
    EOF
    not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "wkhtmltox-#{version}.centos7_sha256sum.txt")}"
  end
  
  execute "install wkhtmltox-#{version}" do
    cwd '/var/daddy/tmp'
    user 'root'
    command <<-EOF
      yum install -y wkhtmltox-#{version}.centos7.x86_64.rpm
    EOF
    not_if "yum info wkhtmltox | grep Version | grep #{version.split('-').first}"
  end
when /rhel-8\.(.*?)/
  execute "download wkhtmltox-#{version}" do
    cwd '/var/daddy/tmp'
    command <<-EOF
      rm -f wkhtmltox-#{version}.centos8.x86_64.rpm
      wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/#{version.split('-').first}/wkhtmltox-#{version}.centos8.x86_64.rpm
    EOF
    not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "wkhtmltox-#{version}.centos8_sha256sum.txt")}"
  end
  
  execute "install wkhtmltox-#{version}" do
    cwd '/var/daddy/tmp'
    user 'root'
    command <<-EOF
      yum install -y wkhtmltox-#{version}.centos8.x86_64.rpm
    EOF
    not_if "yum info wkhtmltox | grep Version | grep #{version.split('-').first}"
  end
end
