module Rod
  module Benchmark
    module ActiveRecord
      class Tag < ::ActiveRecord::Base
        has_and_belongs_to_many :taggings
      end
    end
  end
end
