
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "soft_delete/version"

Gem::Specification.new do |spec|
  spec.name          = "soft_delete"
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

  spec.add_runtime_dependency "activesupport", ">= 3.2, < 6"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "rails", "~> 4.0"
end
