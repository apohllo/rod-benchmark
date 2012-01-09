#!/usr/bin/env ruby

require 'bundler/setup'
$:.unshift "lib"
require 'rod/benchmark/active_record'
require 'srx/polish/sentence_splitter'
require 'srx/polish/word_splitter'
require 'benchmark'

iterations = 10
count = 0
Benchmark.bm do |benchmark|
  %w{text_1.txt text_2.txt}.each do |file|
    iterations.times do |index|
      benchmark.report("#{file}: #{index}") do
        File.open("data/src/#{file}") do |input|
          splitter = SRX::Polish::WordSplitter.new
          index = 0
          input.each do |line|
            index += 1
            break if index > 100000
            splitter.sentence = line
            splitter.each do |word|
              form = Rod::Benchmark::ActiveRecord::WordForm.find_by_value(word.strip)
              if form && form.flexemes.count == 1 &&
                form.flexemes.first.word_forms.count > 1 &&
                form.flexemes.first.taggings.any?{|t| t.tags.map(&:value).include?("subst")}
                count += 1
                #puts form.flexemes.first
              end
            end
          end
        end
      end
    end
  end
end
puts "Matched count #{count/iterations}"
