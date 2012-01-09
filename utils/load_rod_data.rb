#!/usr/bin/env ruby

require 'bundler/setup'
$:.unshift "lib"
require 'rod/benchmark/rod'

flexemes = {}
tags_map = {}
forms = {}
Rod::Benchmark::Rod::Database.instance.create_database("data/rod")
start = Time.now
puts "Loading source data to ROD, this will take a while..."
File.open("data/src/sgjp.txt","r:iso-8859-2:utf-8") do |input|
  input.each.with_index do |line,index|
    next unless index > 1000
    puts "#{index}/5M #{Time.now}" if index % 1000 == 0
    line.chomp!
    form_value, lemma, rest = line.split
    #puts "%-30s %-30s" % [form_value, lemma]
    flexeme = flexemes[lemma]
    if flexeme.nil?
      flexeme = Rod::Benchmark::Rod::Flexeme.new(:lemma => lemma)
      flexemes[lemma] = flexeme
    end
    word_form = forms[form_value]
    if word_form.nil?
      word_form = Rod::Benchmark::Rod::WordForm.new(:value => form_value)
      forms[form_value] = word_form
    end
    unless word_form.flexemes.any?{|f| f.lemma == flexeme.lemma}
      word_form.flexemes << flexeme
    end
    unless flexeme.word_forms.any?{|wf| wf.value == word_form.value}
      flexeme.word_forms << word_form
    end
    rest.split("|").each do |tag_group|
      tags = tag_group.split(":")
      tagging = Rod::Benchmark::Rod::Tagging.new(:flexeme => flexeme)
      tagging.tags =
        tags.map do |tag_name|
          tag = tags_map[tag_name]
          if tag.nil?
            tag = Rod::Benchmark::Rod::Tag.new(:value => tag_name)
            tags_map[tag_name] = tag
          end
          tag
        end
      tagging.store
      flexeme.taggings << tagging
      word_form.taggings << tagging
    end

    break if index > 200000
  end
end

flexemes.each{|l,f| f.store}
tags_map.each{|n,t| t.store}
forms.each{|n,f| f.store}

puts "#{start} -- #{Time.now}"
Rod::Benchmark::Rod::Database.instance.close_database
