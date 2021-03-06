require "cases/helper"

module ActiveRecord
  class CacheKeyTest < ActiveRecord::TestCase
    self.use_transactional_tests = false

    class CacheMe < ActiveRecord::Base; end

    setup do
      @connection = ActiveRecord::Base.connection
      @connection.create_table(:cache_mes) { |t| t.timestamps }
    end

    teardown do
      @connection.drop_table :cache_mes, if_exists: true
    end

    test "cache_key format is not too precise" do
      record = CacheMe.create
      key = record.cache_key

      assert_equal key, record.reload.cache_key
    end
  end
end
