module Rod
  module Benchmark
    module Rod
      class Flexeme < Model
        field :lemma, :string, :index => :hash
        has_one :base_form, :class_name => "Rod::Benchmark::Rod::WordForm"
        has_many :word_forms
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
