module Rod
  module Benchmark
    module Rod
      class Tag < Model
        field :value, :string, :index => :hash

        def to_s
          self.value
        end
      end
    end
  end
end
