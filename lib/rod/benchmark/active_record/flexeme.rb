module Rod
  module Benchmark
    module ActiveRecord
      class Flexeme < ::ActiveRecord::Base
        belongs_to :base_form, :class_name => "Rod::Benchmark::ActiveRecord::WordForm"
        has_and_belongs_to_many :word_forms
        has_many :taggings

        def to_s
          lemma
        end

        def details
          "#{lemma}\n  " +
            taggings.to_a.zip(word_forms.to_a).
            map{|t,f| "%-20s %s" % [f,t]}.join("\n  ")
        end
      end
    end
  end
end
