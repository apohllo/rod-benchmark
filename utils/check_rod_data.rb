#!/usr/bin/env ruby

require 'bundler/setup'
$:.unshift "lib"
require 'rod/benchmark/rod'

Rod::Benchmark::Rod::Database.instance.open_database("data/rod")
Rod::Benchmark::Rod::Flexeme.each.with_index do |flexeme,index|
  puts flexeme.details
  break if index > 10
end
Rod::Benchmark::Rod::Database.instance.close_database
