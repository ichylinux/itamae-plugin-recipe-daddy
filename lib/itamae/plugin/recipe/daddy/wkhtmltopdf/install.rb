require 'daddy/itamae'

version = ENV['WKHTMLTOPDF_VERSION'] || ItamaePluginRecipeDaddy::WKHTMLTOPDF_VERSION

case os_version
when /rhel-6\.(.*?)/
  execute "download wkhtmltopdf-#{version}" do
    cwd '/var/daddy/tmp'
    command <<-EOF
      wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox-#{version}.centos6.x86_64.rpm
    EOF
    not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "wkhtmltox-#{version}_sha256sum.txt")}"
  end
when /rhel-7\.(.*?)/
  execute "download wkhtmltopdf-#{version}" do
    cwd '/var/daddy/tmp'
    command <<-EOF
      rm -f wkhtmltox-#{version}.centos7.x86_64.rpm
      wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox-#{version}.centos7.x86_64.rpm
    EOF
    not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "wkhtmltox-#{version}_sha256sum.txt")}"
  end
end