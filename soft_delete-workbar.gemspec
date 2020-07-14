lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "soft_delete/version"

Gem::Specification.new do |spec|
  spec.name          = "soft_delete-workbar"
  spec.version       = SoftDelete::VERSION
  spec.authors       = ["Richard Davis", "Riki Konikoff"]
  spec.email         = ["riki@workbar.com"]

  spec.summary       = "A no-frills implementation of soft delete for Rails"
  spec.description   = File.read("README.md")
  spec.homepage      = "https://github.com/workbar-dev/soft_delete.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rails"
end
