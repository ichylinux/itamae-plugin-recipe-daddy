require 'daddy/itamae'

version = ENV['PYTHON_VERSION'] || ItamaePluginRecipeDaddy::PYTHON_VERSION

execute "download python-#{version}" do
  cwd '/var/daddy/tmp'
  command <<-EOF
    rm -f Python-#{version}.tar.xz
    wget https://www.python.org/ftp/python/#{version}/Python-#{version}.tar.xz
  EOF
  not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "Python-#{version}_sha256sum.txt")}"
end

execute "install python-#{version}" do
  cwd '/var/daddy/tmp'
  command <<-EOF
    rm -Rf Python-#{version}/
    tar Jxf Python-#{version}.tar.xz
    pushd Python-#{version}
      ./configure --enable-optimizations --with-lto
      make
      sudo make install
    popd
  EOF
  not_if "which python3 && python3 -V | grep 'Python #{version}'" 
end
