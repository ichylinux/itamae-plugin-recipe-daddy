require 'daddy/itamae'

version = ENV['OPENCV_VERSION'] || ItamaePluginRecipeDaddy::OPENCV_VERSION

package 'gtk3-devel' do
  user 'root'
end

execute "download opencv-#{version}" do
  cwd '/var/daddy/tmp'
  command <<-EOF
    rm -f opencv-#{version}.tar.gz
    wget https://github.com/opencv/opencv/archive/#{version}.tar.gz -O opencv-#{version}.tar.gz
  EOF
  not_if "sha256sum -c #{::File.join(::File.dirname(__FILE__), "opencv-#{version}_sha256sum.txt")}"
end

execute "install opencv-#{version}" do
  cwd '/var/daddy/tmp'
  command <<-EOF
    rm -Rf opencv-#{version}/
    tar zxf opencv-#{version}.tar.gz
    pushd opencv-#{version}
      mkdir build
      pushd build
        cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
        make -j7 # doesn't work as expected thread count
        sudo make install
      popd
    popd
  EOF
  not_if "which opencv_version && opencv_version | grep '#{version}'" unless ENV['FORCE']
end
