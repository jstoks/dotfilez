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

message = ARGV.first

if (parts = message.match(/^#(?<id>\d+)\s(?<message>.*)$/)
  id = parts[:id]
  message = parts[:message]
  raise RuntimeError "Tried to commit with 2 ids: [#{options[:id]}, #{id}]" if options[:id] && :id != options[:id]
end
