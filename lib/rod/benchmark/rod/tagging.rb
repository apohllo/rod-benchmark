module Rod
  module Benchmark
    module Rod
      class Tagging < Model
        has_one :flexeme
        has_many :tags

        def to_s
          tags.map{|t| t.value}.join(":")
        end
      end
    end
  end
end
