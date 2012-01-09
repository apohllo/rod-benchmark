module Rod
  module Benchmark
    module ActiveRecord
      class Tagging < ::ActiveRecord::Base
        belongs_to :flexeme
        #belongs_to :word_form
        has_and_belongs_to_many :tags

        def to_s
          tags.map{|t| t.value}.join(":")
        end
      end
    end
  end
end
