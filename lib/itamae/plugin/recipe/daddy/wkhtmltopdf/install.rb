require 'daddy/itamae'

version = ENV['WKHTMLTOPDF_VERSION'] || ItamaePluginRecipeDaddy::WKHTMLTOPDF_VERSION

case os_version
when /rhel-6\.(.*?)/
  execute "download wkhtmltox-#{version}" do
    cwd '/var/daddy/tmp'
    command <<-EOF
      rm -f wkhtmltox-#{version}.centos6.x86_64.rpm
      wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/#{version.split('-').first}/wkhtmltox-#{version}.centos6.x86_64.rpm
    EOF
    not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "wkhtmltox-#{version}.centos6_sha256sum.txt")}"
  end
  
  execute "install wkhtmltox-#{version}" do
    cwd '/var/daddy/tmp'
    user 'root'
    command <<-EOF
      yum install -y wkhtmltox-#{version}.centos6.x86_64.rpm
    EOF
  end
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
  end
end
