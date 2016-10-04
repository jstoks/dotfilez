#!/usr/bin/env ruby

require 'optionparser'

options = {}
OptionParser.new do |opts|
  opts.banner = "usage: #{$0} [options] message"

  opts.on("-i","--id ID","Target Process story id") do |id|
    options[:id] = id
  end
end.parse!

puts options.inspect
puts ARGV.inspect
