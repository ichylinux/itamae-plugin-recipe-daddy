require 'daddy/itamae'

directory 'tmp'

version = ENV['GECKO_DRIVER_VERSION'] || ItamaePluginRecipeDaddy::GECKO_DRIVER_VERSION

execute "download geckodriver-#{version}" do
  cwd 'tmp'
  command <<-EOF
    rm -Rf geckodriver-v#{version}-linux64*
    wget https://github.com/mozilla/geckodriver/releases/download/v#{version}/geckodriver-v#{version}-linux64.tar.gz
  EOF
  not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "geckodriver-v#{version}-linux64_sha256sum.txt")}"
end

execute "install geckodriver-#{version}" do
  cwd 'tmp'
  command <<-EOF
    tar zxf geckodriver-v#{version}-linux64.tar.gz
    sudo mv -f geckodriver /usr/local/bin/
  EOF
  not_if "/usr/local/bin/geckodriver -V | grep 'geckodriver #{version}'"
end
