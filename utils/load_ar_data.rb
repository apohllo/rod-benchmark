#!/usr/bin/env ruby

require 'bundler/setup'
$:.unshift "lib"
require 'rod/benchmark/active_record'
require 'rod/benchmark/active_record/schema'
require 'benchmark'

start = Time.now
#Benchmark.bm do |bm|
#bm.report "AR(sqlite) load" do
puts "Loading source data to datase via ActiveRecord, this will take a while..."
File.open("data/src/sgjp.txt","r:iso-8859-2:utf-8") do |input|
  Rod::Benchmark::ActiveRecord::Flexeme.transaction do
    input.each.with_index do |line,index|
      begin
        next unless index > 1000
        puts "#{index}/200k #{Time.now}" if index % 1000 == 0
        line.chomp!
        form_value, lemma, rest = line.split
        #puts "%-30s %-30s" % [form_value, lemma]
        flexeme = Rod::Benchmark::ActiveRecord::Flexeme.find_by_lemma(lemma)
        if flexeme.nil?
          flexeme = Rod::Benchmark::ActiveRecord::Flexeme.new(:lemma => lemma)
          flexeme.save
        end
        word_form = Rod::Benchmark::ActiveRecord::WordForm.find_by_value(form_value)
        if word_form.nil?
          word_form = Rod::Benchmark::ActiveRecord::WordForm.new(:value => form_value)
          word_form.save
        end
        word_form.flexemes << flexeme unless word_form.flexemes.include?(flexeme)
        flexeme.word_forms << word_form unless flexeme.word_forms.include?(word_form)
        rest.split("|").each do |tag_group|
          tags = tag_group.split(":")
          tagging = Rod::Benchmark::ActiveRecord::Tagging.new(:flexeme => flexeme)
          tagging.tags =
            tags.map do |tag_name|
              tag = Rod::Benchmark::ActiveRecord::Tag.find_by_value(tag_name)
              if tag.nil?
                tag = Rod::Benchmark::ActiveRecord::Tag.new(:value => tag_name)
                tag.save
              end
              tag
            end
          tagging.save
          flexeme.taggings << tagging
          word_form.taggings << tagging
        end
        flexeme.save
        word_form.save

        break if index > 200000
      rescue Exception => ex
        puts ex
        puts line
      end
    end
  end
end
puts "#{start} -- #{Time.now}"
#end
#end
