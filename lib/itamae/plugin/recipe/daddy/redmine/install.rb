%w{
  ImageMagick
  ImageMagick-devel
  ipa-pgothic-fonts
  libcurl-devel
  libffi-devel  
  libyaml-devel
  openssl-devel
  postgresql-devel
  postgresql-server
  readline-devel
  zlib-devel
}.each do |name|
  package name do
    user 'root'
  end
end
