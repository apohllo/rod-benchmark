module Rod
  module Benchmark
    module Rod
      class WordForm < Model
        field :value, :string, :index => :hash
        has_many :flexemes
        has_many :taggings

        def to_s
          self.value
        end
      end
    end
  end
end
