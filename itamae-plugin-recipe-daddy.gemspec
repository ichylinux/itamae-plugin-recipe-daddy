
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "itamae_plugin_recipe_daddy/version"

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-recipe-daddy"
  spec.version       = ItamaePluginRecipeDaddy::VERSION
  spec.authors       = ["ichy"]
  spec.email         = ["ichylinux@gmail.com"]

  spec.summary       = %q{itamae recipe collections}
  spec.description   = %q{itamae recipe collections}
  spec.homepage      = "https://github.com/ichylinux/itamae-plugin-recipe-daddy"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'itamae', '~> 1.10', '>= 1.10.2'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.3"
end
