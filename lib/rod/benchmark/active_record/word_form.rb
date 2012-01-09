module Rod
  module Benchmark
    module ActiveRecord
      class WordForm < ::ActiveRecord::Base
        has_and_belongs_to_many :flexemes
        has_many :taggings

        def to_s
          self.value
        end
      end
    end
  end
end

