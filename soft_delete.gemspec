
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "soft_delete/version"

Gem::Specification.new do |spec|
  spec.name          = "soft_delete"
  spec.version       = SoftDelete::VERSION
  spec.authors       = ["Richard Davis", "Riki Konikoff"]
  spec.email         = ["riki@workbar.com"]

  spec.summary       = "A no-frills implementation of soft delete for Rails"
  spec.description   = %q{
    Soft Delete

    Safely "delete" records from your database without losing them permanently.

    Usage:
    * Install the gem `gem install soft_delete`, or, in your gemfile: `gem "soft_delete"`
    * Add SoftDelete to a model
      ```
      class MyModel
        include SoftDelete
      end
      ```
    * Add a `deleted_at` column to the model's database table
      ```
      rails g migration add_soft_delete_to_my_models add_column my_models deleted_at timestamp
      ```
    * Safely call MyModel#delete without losing the record forever

  }
  spec.homepage      = "https://github.com/workbar-dev/soft_delete.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 4.0"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "rails", ">= 4.0"
end
