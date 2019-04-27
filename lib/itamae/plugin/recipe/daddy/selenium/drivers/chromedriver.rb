version = ENV['CHROME_DRIVER_VERSION'] || ItamaePluginRecipeDaddy::CHROME_DRIVER_VERSION

execute "download chromedriver-#{version}" do
  cwd '/var/daddy/tmp'
  command <<-EOF
    curl -o chromedriver_linux64-#{version}.zip \
        https://chromedriver.storage.googleapis.com/#{version}/chromedriver_linux64.zip
  EOF
  not_if "echo #{::File.read(::File.join(::File.dirname(__FILE__), "chromedriver_linux64-#{version}_sha256sum.txt")).strip} | sha256sum -c"
end

execute "install chromedriver-#{version}" do
  cwd '/var/daddy/tmp'
  command <<-EOF
    unzip chromedriver_linux64-#{version}.zip
    sudo mv -f chromedriver /usr/local/bin/
  EOF
  not_if "/usr/local/bin/chromedriver -v | grep 'ChromeDriver #{version}'"
end
