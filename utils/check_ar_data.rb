#!/usr/bin/env ruby

require 'bundler/setup'
$:.unshift "lib"
require 'rod/benchmark/active_record'

Rod::Benchmark::ActiveRecord::Flexeme.all.each.with_index do |flexeme,index|
  puts flexeme.details
  break if index > 10
end
