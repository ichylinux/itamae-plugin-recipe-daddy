require_relative 'version'

def self.os_version
  "#{node.platform_family}-#{node.platform_version}"
end
