require "bundler/setup"
require "active_record"
require "active_support"
require "soft_delete"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before do
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
    ActiveRecord::Schema.define(version: 1) do
      create_table :test_models do |t|
        t.string :name
        t.datetime :deleted_at
      end
    end

    class TestModel < ActiveRecord::Base
      include SoftDelete

      after_destroy :after_destroy_do_this
      def after_destroy_do_this; end
    end
  end

  config.after { TestModel.delete_all }
end
